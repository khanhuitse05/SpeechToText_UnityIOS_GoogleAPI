using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class SampleSpeechToText : MonoBehaviour {

    public SpeechToText speech;
    public Text txtStatus;
    public Text txtResult;
    public Dropdown dropdown;
    void Start () {
        txtResult.text = "";
        txtStatus.text = "";
#if UNITY_IPHONE
        speech.onStart = OnStartSpeech;
        speech.onStop = OnStopSpeech;
        speech.onResult = OnResultSpeech;
#endif
    }

    bool isRecording = false;
    public void btnClick()
    {
#if UNITY_IPHONE
        if (isRecording == false)
        {
            speech.startRecording();
        }
        else
        {
            speech.stopRecording();
        }
#endif
    }
    public void dropdownChange()
    {
        string lang = "en-US";
        if (dropdown.value == 0)
        {
            lang = "en-US";
        }
        else if (dropdown.value == 1)
        {
            lang = "Vietnamese";
        }
#if UNITY_IPHONE
        speech.changeLanguage(lang);
#endif
    }
#if UNITY_IPHONE
    void OnStartSpeech()
    {
        txtStatus.text = "Recoding...";
    }

    void OnStopSpeech()
    {
        txtStatus.text = "";
    }

    void OnResultSpeech(string _data)
    {
        char[] delimiterChars = { ',' };
        string[] words = _data.Split(delimiterChars);
        txtResult.text = "";
        for (int i = 0; i < words.Length; i++)
        {
            if (i == 0)
            {
                txtResult.text = words[i];
            }
            else
            {
                txtResult.text += "\n"+words[i];
            }
        }
    }
#endif
}
