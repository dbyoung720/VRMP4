/*
  Func: Video Capture : Preview、Snap、Record(MP4)、Live, four in all
  Auth: dbyoung@sina.com
  Time��2021-05-15
*/

#ifndef _DLL_RMP4_H_
#define _DLL_RMP4_H_

#ifdef DLLRMP4_EXPORTS
#define DLL_RMP4 _declspec(dllexport)
#else
#define DLL_RMP4 _declspec(dllimport)
#endif

#include <dshow.h>

/* Video input device information */
typedef struct {
  name  : char[256];
  index : int;
};TVideoInputDeviceInfo, *PVideoInputDeviceInfo;

/* Format information supported by video device */
typedef struct {
  FormatType : char[10];
  FormatInfo : char[12];
  width   : int;
  height  : int;
}; TVideoFormat, *PVideoFormat;

/* 
    MP4 Video hardware acceleration encoding type
    hwNone   : No hardware acceleration encoding
    hwIntel  : Using Intel  video card hardware to acceleration encoding  < Intel 630 or above graphics card        >
    hwNvidia : Using NVIDIA video card hardware to acceleration encoding  < NVIDIA Geforce 1030 above graphics card > <https://developer.nvidia.com/video-encode-and-decode-gpu-support-matrix-new>
*/
typedef enum 
{
  hwNone   = 0x00, 
  hwIntel  = 0x01, 
  hwNvidia = 0x02,
} THardwareAccel;

#ifdef __cplusplus
extern "C" 
{
#endif

/* Get list of video input devices */
DLL_RMP4 bool GetVideoInputDeviceList(PVideoInputDeviceInfo* DeviceInfo, int* count); 

/* Get list of formats supported by the video input device */
DLL_RMP4 bool GetVideoInputDeviceSupportFormat(const char* strDeviceName, PVideoFormat* avf, int* count);

/* 
	Start video preview
	pClass        : Pointer implementing ISampleGrabberCB interface class;
  strDeviceName : Video input device name;
  width, height : Video width and height;
  strFormat     : Video type;
  hVideoWindow  : Video preview window handle;
*/
DLL_RMP4 bool VideoPreviewStart(const void* pClass, const char* strDeviceName, const int width, const int height, const int hVideoHandle);

/* Stop video preview */
DLL_RMP4 bool VideoPreviewStop(); 

/* Video preview UI drawing */
DLL_RMP4 bool VideoPreviewDraw(IMediaSample pSample);

/* Snap bitmap */
DLL_RMP4 bool VideoSnapBmp(HBITMAP hBmp);

/*  
  Start MP4 video recording and network streaming. Both can operate independently or simultaneously;
  strSaveMP4Path  :  MP4 video save path;
  strLiveURL      :  rtmp network streaming address;
  bRecordMP4      :  Whether to start MP4 video recording. If recording is enabled, the strSaveMP4Path parameter cannot be empty;
  bLive           :  Whether to start network streaming.   If streaming is enabled, the strLiveURL     parameter cannot be empty;
  intHardAccelType:  Hardware accelerated MP4 video coding type; hwNone、hwIntel、hwNvidia, Optional;
*/
DLL_RMP4 bool VideoRecordMP4(const char* strSaveMP4Path, const char* strLiveURL, const bool bRecordMP4, const bool bLive, const int intHardAccelType = 0);

#ifdef __cplusplus
};
#endif

#endif
