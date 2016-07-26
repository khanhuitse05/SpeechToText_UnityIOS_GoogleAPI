using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using UnityEngine.UI;
using System;

public class SpeechToText : MonoBehaviour {

#if UNITY_IPHONE
    static public SpeechToText instance;
    public Action onStart;
    public Action onStop;
    public Action<string> onResult;
    public string keySpeechIOS = "";
    [DllImport("__Internal")]
	private static extern void _TAG_initSpeech(string myString);

    [DllImport("__Internal")]
    private static extern void _TAG_startRecording();

    [DllImport("__Internal")]
    private static extern void _TAG_stopRecording();

    [DllImport("__Internal")]
    private static extern void _TAG_changeLanguage(string lang);


    public void startRecording()
    {
        _TAG_startRecording();
    }
    public void stopRecording()
    {
        _TAG_stopRecording();
    }
    public void changeLanguage(string lang)
    {
        _TAG_changeLanguage(lang);
    }

    void Start()
    {
        _TAG_initSpeech(keySpeechIOS);
        instance = this;
    }

    void CallbackSpeechToText(string _message)
    {
        if (onResult != null)
        {
            onResult(_message);
        }
    }
    void CallbackStatus(string _message)
    {
        switch (_message)
        {
            case "init":
                break;
            case "start":
                if (onStart != null)
                {
                    onStart();
                }
                break;
            case "stop":
                if (onStop != null)
                {
                    onStop();
                }
                break;
            case "error":
                Debug.Log("Speech to text has Error result. Please check your key.");
                break;
            default:
                break;
        }
    }
#endif
}
