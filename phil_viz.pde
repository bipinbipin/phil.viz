import processing.sound.*;

AudioIn input;
SoundFile audioFile;
Amplitude analyzer;
FFT fft;
int bands = 8;
float[] spectrum = new float[bands];
float smoothedBackground = 0;
color[] palette = new color[7];
ArrayList<ReactiveCircle> circles = new ArrayList<ReactiveCircle>();

void setup() {
  setupPalette();
  size(800, 800);
  frameRate(6);
  //System.out.println(Sound.list());
  input = new AudioIn(this, 0);
  input.start();

  audioFile = new SoundFile(this, "phil.mp3");
  audioFile.loop();

  analyzer = new Amplitude(this);
  analyzer.input(audioFile);
  
  fft = new FFT(this, bands);
  fft.input(audioFile);
  
  // initialize Circles
  for(int j = 0; j < bands; j++) {
   circles.add(new ReactiveCircle( randomColorFromPalette()));
  }
  System.out.println(circles.size());
}

void draw() {
  

  // Get the overall volume (between 0 and 1.0)
  float overallVolume = analyzer.analyze();
  float volumeShade = map(overallVolume, 0, 1, 255, 0);
  smoothedBackground = lerp(smoothedBackground, volumeShade, 0.1);
  
  background(smoothedBackground);
  
  fft.analyze(spectrum);
  
  
  
  
  for(int i = 0; i < bands; i++) {
      fill(120);
      text(spectrum[i], 10, 20 + i*12);
      
      ReactiveCircle c = circles.get(i);
      c.display();

      //ellipse(xy[0], xy[1], spectrum[i]*1000, spectrum[i]*1000);
      
  }
  
}

int[] randomCoordinate() {
   int[] xy = new int[2];
   xy[0] = (int) random(0, width);
   xy[1] = (int) random(0, height);
   
   return xy;
}

color randomColorFromPalette() {
   return palette[ (int) random(0, palette.length) ];
}

void setupPalette() {

  palette[0] =#e67226;
  palette[1] =#a89205;
  palette[2] =#63a256;
  palette[3] =#2ca2a5;
  palette[4] =#7a91d0;
  palette[5] =#d76fb7;
  palette[6] =#fd586f;

}
