Graph graph;
Complex[] data;
Euler[] sins;
Euler[] simple;
float[][] circles;
float[][] simpleCircles;
int timeSpan;
int time;
float delta;
float axisX;
float axisY;

void setup() {
  size(1600, 1000);
  axisX = 7.5;
  axisY = 5;
  
  graph = new Graph(width, axisX, -axisX, 0.5, height, axisY = 5, -axisY, 0.5);
  int numSins = 243;
  data = readTempFile(dataPath("") + "\\house.txt");
  timeSpan = data.length;
  time = 0;
  sins = fourier(data, numSins);
  sortSins(sins);
  
  simple = new Euler[sins.length/10];
  for (int i = 0; i < simple.length; ++i) {
    simple[i] = sins[i];
  }
  circles = new float[data.length][2];
  simpleCircles = new float[data.length][2];
}

void draw() {
  if (time >= timeSpan) {
    time = 0;
    delta *= -1;
  }
  axisX = circles[time][0];
  axisY = circles[time][1];
  //graph = new Graph(width, axisX+0.1, axisX-0.1, 0.5, height, axisY+0.03, axisY-0.03, 0.5);
  background(50, 200, 255);
  graph.drawAxis(true);
  
  // Draws the original file
  for (int i = 1; i < data.length; ++i) {
    float x1 = graph.pixelx(data[i-1].real);
    float y1 = graph.pixely(data[i-1].imag);
    float x2 = graph.pixelx(data[i].real);
    float y2 = graph.pixely(data[i].imag);
    line(x1, y1, x2, y2);
  }
  
  float[] prevEnd = drawSins(sins, time, graph);
  
  circles[time][0] = prevEnd[0];
  circles[time][1] = prevEnd[1];
  
  prevEnd = drawSins(simple, time, graph);
  
  simpleCircles[time][0] = prevEnd[0];
  simpleCircles[time][1] = prevEnd[1];
  
  for (int i = 0; i < time + 1; ++i) {
    fill(0);
    circle(graph.pixelx(circles[i][0]), graph.pixely(circles[i][1]), height/100);
    fill(255);
    circle(graph.pixelx(simpleCircles[i][0]), graph.pixely(simpleCircles[i][1]), height/100);
    //fill(255);
  }
  
  time += 1;
}

public Complex[] readTempFile(String filename) {
  Complex[] data = null;
  try {
      ArrayList<Complex> dataList = new ArrayList<Complex>();
      File file = new File(filename);
      Scanner reader = new Scanner(file);
      //System.out.println("Created Scanner");
      
      float real;
      float imag;
      Scanner numReader;
      
      while (reader.hasNextLine()) {
        //System.out.println("Entered while loop...");
        String tempStr = reader.nextLine();
        //System.out.println(tempStr);
        String[] temp = tempStr.split("[+]",2);
        numReader = new Scanner(temp[0]);
        real = (float) numReader.nextDouble();
        //System.out.println("  Real: " + real);
        numReader.close();
        numReader = new Scanner(temp[1].substring(0, temp[1].length()-1));
        imag = (float) numReader.nextDouble();
        //System.out.println("  Imag: " + imag);
        dataList.add(new Complex(real, imag));
      }
      
      data = new Complex[dataList.size()];
      data = dataList.toArray(data);
      
      reader.close();
    } catch (FileNotFoundException e) {
      System.out.println("ERROR: File was not found");
    } catch (IOException e) {
      System.out.println("ERROR: An error occured while reading the file");
    } catch (Error e) {
      System.out.println("ERROR: Some unexpected error occured");
    }
    
    return data;
}

/**
 * This method completes a discrete Fourier transform for a discrete data set
 * @param data a dicrete signal comprized of complex numbers
 * @param N the number of sinusoids used in the signal
 * @return a set of euler sinusoids with a length of N
 */
public Euler[] fourier(Complex[] data, int N) {
  Complex[] coefs = new Complex[N];
  
  // Gets the complex coefficients of each frequency
  for (int i = 0; i < N; ++i) {
    Euler multiplier = new Euler(1, 0, -2*PI*(float)i/((float)N));
    coefs[i] = multiplier.getTime(0).product(data[0]);
    
    for (int j = 1; j < data.length; ++j) {
      coefs[i] = coefs[i].sum(multiplier.getTime(j).product(data[j]));
    }
    coefs[i] = new Complex(coefs[i].real/((float)N), coefs[i].imag/((float)N));
  }
  
  // Generates a list of complex Euler sinusoids
  Euler[] sins = new Euler[N];
  for (int i = 0; i < N; ++i) {
    sins[i] = new Euler(coefs[i].getMag(), coefs[i].getAng(), 2*PI*(float)i/((float)N));
  }
  
  return sins;
}
  
public void sortSins(Euler[] input) {
  // Sorts the sinusoids by magnitude
  for (int i = 0; i < input.length; ++i) {
    for (int j = 1; j < input.length; ++j) {
      if (input[j].mag > input[j-1].mag) {
        Euler temp = input[j];
        input[j] = input[j-1];
        input[j-1] = temp;
      }
    }
  }
}

public float[] drawSins(Euler[] sins, float time, Graph graph) {
  float[] prevEnd = {0, 0};
  float[] newEnd;
  
  // Draws each arrow end to end
  //System.out.println("Entering for loop - Time: " + time + " Time Span: " + timeSpan);
  for (int i = 0; i < sins.length; ++i) {
    Complex sin = sins[i].getTime(time);
    newEnd = new float[]{prevEnd[0] + sin.real, prevEnd[1] + sin.imag};
    new Arrow(prevEnd, newEnd).draw(graph);
    prevEnd = newEnd;
  }
  
  return prevEnd;
}
