unit rMP4;
{
  Func: Video Capture : Preview、Snap、Record(MP4)、Live, four in all
  Auth: dbyoung@sina.com
  Time��2021-05-15
}

interface

uses Winapi.Windows, Winapi.DirectShow9;

type
  { Video input device information }
  PVideoInputDeviceInfo = ^TVideoInputDeviceInfo;

  TVideoInputDeviceInfo = record
    name: array [0 .. 255] of AnsiChar;
    index: Integer;
  end;

  { Format information supported by video device }
  PVideoFormat = ^TVideoFormat;

  TVideoFormat = record
    FormatType: array [0 .. 9] of AnsiChar;
    FormatInfo: array [0 .. 11] of AnsiChar;
    width: Integer;
    height: Integer;
  end;

  {
    MP4 Video hardware acceleration encoding type
    hwNone   : No hardware acceleration encoding
    hwIntel  : Using Intel  video card hardware to acceleration encoding  < Intel 630 or above graphics card        >
    hwNvidia : Using NVIDIA video card hardware to acceleration encoding  < NVIDIA Geforce 1030 above graphics card > <https://developer.nvidia.com/video-encode-and-decode-gpu-support-matrix-new>
  }
  THardwareAccel = (hwNone, hwIntel, hwNvidia);

{ Get list of video input devices }
function GetVideoInputDeviceList(var DeviceInfo: PVideoInputDeviceInfo; var Count: Integer): Boolean; stdcall; external 'rMP4.dll';

{ Get list of formats supported by the video input device }
function GetVideoInputDeviceSupportFormat(const strDeviceName: PAnsiChar; var avf: PVideoFormat; var Count: Integer): Boolean; stdcall;  external 'rMP4.dll';

{ 
	Start video preview
	pClass        : Pointer implementing ISampleGrabberCB interface class;
  strDeviceName : Video input device name;
  width, height : Video width and height;
  strFormat     : Video type;
  hVideoWindow  : Video preview window handle;
}
function VideoPreviewStart(const pClass: Pointer; const strDeviceName: PAnsiChar; const width, height: Integer; const strFormat: PAnsiChar; hVideoWindow: THandle): Boolean; stdcall; external 'rMP4.dll';

{ Stop video preview }
function VideoPreviewStop: Boolean; stdcall; external 'rMP4.dll';

{ Video preview UI drawing }
function VideoPreviewDraw(pSample: IMediaSample): Boolean; stdcall;  external 'rMP4.dll';

{ Snap bitmap }
function VideoSnapBmp(hBmp: HBITMAP): Boolean; stdcall;  external 'rMP4.dll';

{ 
  Start MP4 video recording and network streaming. Both can operate independently or simultaneously;
  bRecordMP4      :  Whether to start MP4 video recording. If recording is enabled, the strSaveMP4Path parameter cannot be empty;
  bLive           :  Whether to start network streaming.   If streaming is enabled, the strLiveURL     parameter cannot be empty;
  strSaveMP4Path  :  MP4 video save path;
  strLiveURL      :  rtmp network streaming address;
  intHardAccelType:  Hardware accelerated MP4 video coding type; hwNone、hwIntel、hwNvidia, Optional;
}
function VideoRecordMP4(const strMP4FileName, strLiveUrl: PAnsiChar; const bMP4Record, bLive: Boolean; const intHardAccelType: Integer = 0) : Boolean; stdcall;  external 'rMP4.dll';

implementation

end.
