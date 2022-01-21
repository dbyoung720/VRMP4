unit Unit1;

interface

uses
  Winapi.Windows, Winapi.DirectShow9, System.Classes, System.SysUtils, System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TForm1 = class(TForm, ISampleGrabberCB)
    pmVideoPreview: TPopupMenu;
    mniVideoPrevideo: TMenuItem;
    grpVideoInput: TGroupBox;
    lstVideoInput: TListBox;
    grpVideoFormat: TGroupBox;
    lstVideoFormat: TListBox;
    grp1: TGroupBox;
    pnlVideo: TPanel;
    btnPreview: TButton;
    btnSnap: TButton;
    imgSnap: TImage;
    lbl2: TLabel;
    edtLive: TEdit;
    lbl1: TLabel;
    edtSavePath: TEdit;
    chkLive: TCheckBox;
    chkMP4Record: TCheckBox;
    cbbHardAccel: TComboBox;
    lbl3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvVideoInputClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnSnapClick(Sender: TObject);
    procedure lstVideoFormatClick(Sender: TObject);
    procedure chkMP4RecordClick(Sender: TObject);
    procedure chkLiveClick(Sender: TObject);
  private
    FbSnapBmp         : Boolean;
    FSnapBmp          : TBitmap;
    FbStopVideoPreview: Boolean;
    procedure EnumVideoInputDevice;
    procedure EnableUI(const bEnable: Boolean);
    procedure CreateSnapBmp(const intWidth, intHeight: Integer);
    function SampleCB(SampleTime: Double; pSample: IMediaSample): HResult; stdcall;
    function BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
  end;

var
  Form1: TForm1;

implementation

uses rMP4;

{$R *.dfm}

{ 枚举视频输入设备 }
procedure TForm1.EnumVideoInputDevice;
var
  vif: PVideoInputDeviceInfo;
  len: Integer;
  I  : Integer;
begin
  vif := nil;
  len := 0;
  if not GetVideoInputDeviceList(vif, len) then
    Exit;

  for I := 0 to len - 1 do
  begin
    lstVideoInput.Items.Add(string(vif^.name));
    inc(vif);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  { 初始化成员变量 }
  edtSavePath.Text   := Format('D:\%s.MP4', [FormatDateTime('yyyyMMdd', Now)]);
  edtLive.Text       := 'rtmp://localhost:1935/live';
  FbSnapBmp          := False;
  FbStopVideoPreview := False;

  { 枚举视频输入设备 }
  EnumVideoInputDevice;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  { 预览进行中，停止预览 }
  VideoPreviewStop;

  { 销毁成员变量 }
  if Assigned(FSnapBmp) then
    FSnapBmp.Free;
end;

procedure TForm1.lstVideoFormatClick(Sender: TObject);
begin
  if lstVideoFormat.ItemIndex = -1 then
    Exit;

  btnPreview.Enabled := lstVideoFormat.ItemIndex <> -1;
end;

procedure TForm1.lvVideoInputClick(Sender: TObject);
var
  avf          : PVideoFormat;
  Count        : Integer;
  I            : Integer;
  strValue     : String;
  strDeviceName: PAnsiChar;
begin
  btnPreview.Enabled := False;
  btnSnap.Enabled    := False;
  if lstVideoInput.ItemIndex = -1 then
    Exit;

  { 枚举视频设备支持的视频格式 }
  lstVideoFormat.Clear;
  lstVideoFormat.Sorted := True;
  avf                   := nil;
  Count                 := 0;
  strDeviceName         := PAnsiChar(AnsiString(lstVideoInput.Items[lstVideoInput.ItemIndex]));
  if not GetVideoInputDeviceSupportFormat(strDeviceName, avf, Count) then
    Exit;

  if Count = 0 then
    Exit;

  for I := 0 to Count - 1 do
  begin
    strValue := Format('类型：%6s  格式：%12s  分辨率：%4d X %4d', [avf^.FormatType, avf^.FormatInfo, avf^.Width, avf^.Height]);
    lstVideoFormat.Items.Add(strValue);
    inc(avf);
  end;
end;

procedure TForm1.EnableUI(const bEnable: Boolean);
begin
  lstVideoInput.Enabled  := not bEnable;
  lstVideoFormat.Enabled := not bEnable;
  chkLive.Enabled        := bEnable;
  chkMP4Record.Enabled   := bEnable;
  btnPreview.Caption     := Ifthen(bEnable, '停止', '开始');
  btnSnap.Enabled        := bEnable;
  cbbHardAccel.Enabled   := True;

  if not bEnable then
  begin
    chkLive.Checked      := False;
    chkMP4Record.Checked := False;
    pnlVideo.Invalidate;
  end;
end;

{ 创建截图位图 }
procedure TForm1.CreateSnapBmp(const intWidth, intHeight: Integer);
begin
  if Assigned(FSnapBmp) then
    FSnapBmp.Free;

  FSnapBmp             := TBitmap.Create;
  FSnapBmp.PixelFormat := pf32bit;
  FSnapBmp.Width       := intWidth;
  FSnapBmp.Height      := intHeight;
end;

{ 开始视频预览 }
procedure TForm1.btnPreviewClick(Sender: TObject);
var
  strDeviceName: String;
  strValue     : String;
  intWidth     : Integer;
  intHeight    : Integer;
  strFormat    : String;
begin
  btnPreview.Enabled := False;
  Application.ProcessMessages;
  try
    if btnPreview.Caption = '停止' then
    begin
      { 停止预览 }
      FbStopVideoPreview := True;
      VideoPreviewStop;
      EnableUI(False);
    end
    else
    begin
      FbStopVideoPreview := False;

      strDeviceName := lstVideoInput.Items[lstVideoInput.ItemIndex];
      strValue      := RightStr(lstVideoFormat.Items[lstVideoFormat.ItemIndex], 11);
      intWidth      := StrToInt(Trim(strValue.Split(['X'])[0]));
      intHeight     := StrToInt(Trim(strValue.Split(['X'])[1]));

      strValue  := LeftStr(lstVideoFormat.Items[lstVideoFormat.ItemIndex], 11);
      strFormat := Trim(RightStr(strValue, 8));

      { 创建截图位图 }
      CreateSnapBmp(intWidth, intHeight);

      { 开始预览 }
      VideoPreviewStart(Form1, PAnsiChar(AnsiString(strDeviceName)), intWidth, intHeight, PAnsiChar(AnsiString(strFormat)), pnlVideo.Handle);
      EnableUI(True);
    end;
  finally
    btnPreview.Enabled := True;
  end;
end;

{ 回调函数。需要尽快处理，否则会影响回调的返回 }
function TForm1.SampleCB(SampleTime: Double; pSample: IMediaSample): HResult;
begin
  Result := S_OK;

  { 停止视频预览时，立即退出回调 }
  if FbStopVideoPreview then
    Exit;

  { 视频预览界面绘制 }
  if not VideoPreviewDraw(pSample) then
    Exit;

  { 视频截图 }
  if FbSnapBmp then
  begin
    VideoSnapBmp(FSnapBmp.Handle);
    imgSnap.Picture.Bitmap.Assign(FSnapBmp);
    FbSnapBmp := False;
  end;

  { 视频录制 MP4 并推流 }
  VideoRecordMP4(PAnsiChar(AnsiString(edtSavePath.Text)), PAnsiChar(AnsiString(edtLive.Text)), chkMP4Record.Checked, chkLive.Checked, cbbHardAccel.ItemIndex);
end;

function TForm1.BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult;
begin
  Result := S_OK;
end;

procedure TForm1.chkLiveClick(Sender: TObject);
begin
  if not chkMP4Record.Checked then
    cbbHardAccel.Enabled := not chkLive.Checked;
end;

procedure TForm1.chkMP4RecordClick(Sender: TObject);
begin
  if not chkLive.Checked then
    cbbHardAccel.Enabled := not chkMP4Record.Checked;
end;

procedure TForm1.btnSnapClick(Sender: TObject);
begin
  FbSnapBmp := True;
end;

end.
