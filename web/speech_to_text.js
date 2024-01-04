let audioContext;
let mediaStreamSource;
let scriptProcessor;
let pushStream;
let recognizer;

let mediaRecorder;

window.startRecording = async function (config) {
  if (navigator.mediaDevices.getUserMedia) {
    console.log("getUserMedia supported.");
    const constraints = { audio: true };

    let onError = function (err) {
      console.log("The following error occurred: " + err);
    };

    let onSuccessType = function (stream) {
      mediaRecorder = new MediaRecorder(stream);
      console.log("onSuccess");
      initSpeechSDK(stream, config);
    };

    navigator.mediaDevices
      .getUserMedia(constraints)
      .then(onSuccessType, onError);
  } else {
    console.log("getUserMedia not supported on your browser!");
  }
};

async function initSpeechSDK(stream, config) {
  const apiKey = config.apiKey;
  const region = config.region;
  const endpointId = config.endpointId;
  const speechConfig = SpeechSDK.SpeechConfig.fromSubscription(apiKey, region);
  speechConfig.endpointId = endpointId;
  speechConfig.enableAudioLogging();
  speechConfig.setProperty(
    SpeechSDK.PropertyId.SpeechServiceConnection_InitialSilenceTimeoutMs,
    "1000"
  );
  speechConfig.speechRecognitionLanguage = "ja-JP";

  const audioConfig = SpeechSDK.AudioConfig.fromStreamInput(stream);
  recognizer = new SpeechSDK.SpeechRecognizer(speechConfig, audioConfig);

  recognizer.recognizing = (s, e) => {
    console.log(`RECOGNIZING: 。。。。`);
  };

  recognizer.recognized = (s, e) => {
    if (e.result && e.result.text) {
      window.parent.postMessage(
        { type: "recognized", message: e.result.text },
        "*"
      );
    } else {
      console.log("RECOGNIZED: No valid text recognized");
    }
  };

  recognizer.startContinuousRecognitionAsync();
}

window.stopRecording = function () {
  if (mediaRecorder && mediaRecorder.state === "recording") {
    mediaRecorder.stop();
    console.log("Recording stopped.");
  } else {
    console.log("No active recording to stop.");
  }

  if (recognizer) {
    recognizer.stopContinuousRecognitionAsync(
      () => {
        console.log("Recognition stopped.");
      },
      (err) => {
        console.log("Error occurred while stopping recognition: " + err);
      }
    );
  } else {
    console.log("No active recognition to stop.");
  }
};
