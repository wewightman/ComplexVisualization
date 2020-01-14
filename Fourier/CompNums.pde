import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

public class Complex {
  public float real;
  public float imag;
  
  public Complex(float real, float imag) {
    this.real = real;
    this.imag = imag;
  }
  
  /**
   * This method calculates the angle of the vector
   * @return the angle of this complex between +/- PI
   */
  public float getAng() {
    return (float) Math.atan2(this.imag, this.real);
  }
  
  /**
   * This method gets the magnitude of the complex number
   * @return the magnitude of this complex number
   */
  public float getMag() {
    return (float)Math.sqrt(real*real + imag*imag);
  }
  
  public Complex product(Complex second) {
    float real = this.real*second.real-this.imag*second.imag;
    float imag = this.imag*second.real + this.real*second.imag;
    
    return new Complex(real, imag);
  }
  
  public Complex sum(Complex second) {
    float real = this.real + second.real;
    float imag = this.imag + second.imag;
    
    return new Complex(real, imag);
  }
  
  public String toString() {
    return "" + real + " + " + imag + "*i";
  }
} 

public class Euler {
  public float mag;
  public float phi;
  public float omega;
  
  // Constructor
  public Euler(float mag, float phi, float omega) {
    this.mag = mag;
    this.phi = phi;
    this.omega = omega;
  }
  
  // Returns a complex at a given time
  public Complex getTime(float time) {
    return new Complex(mag*cos(omega*time+phi),mag*sin(omega*time+phi));
  }
  
  public String toString() {
    return "" + mag + "\t" + phi + "\t" + omega;
  }
}
