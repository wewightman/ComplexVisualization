class Graph {
  // x data
  private float xlim;
  private float xmax;
  private float xmin;
  private float xtick;
  private float xzero;
  private float pxpnx; // Pixels (x) per number x
  
  // y data
  private float ylim;
  private float ymax;
  private float ymin;
  private float ytick;
  private float yzero;
  private float pypny; // Pixels (y) per number y
  
  /**
   * Contructor that builds the pure numerical to pixel coordinates
   */
  public Graph(float xlim, float xmax, float xmin, float xtick, float ylim, float ymax, float ymin, float ytick) {
    this.xlim = xlim; this.xmax = xmax; this.xmin = xmin; this.xtick = xtick;
    this.ylim = ylim; this.ymax = ymax; this.ymin = ymin; this.ytick = ytick;
    
    this.pxpnx = xlim/(xmax-xmin); // Calculates pixels per unit one on x axis
    this.pypny = ylim/(ymax-ymin); // Calculates pixels per unit one on y axis
    this.xzero = -xmin*pxpnx; // Calculates the px zero
    this.yzero = ymax*pypny; // Calculates the py zero
  }
  
  /**
   * This method converts a numerical value in x to a pixel
   * @param orig this is the numerical coordinte you wish to plot
   * @return the pixel that number coordinates to as a float
   */
  public float pixelx(float num) {
    return num*pxpnx + xzero;
  }
  
  /**
   * This method converts a pixel value in the x axis to a numerical value
   * @param pix the x pixel value
   * @return the numerical value according to this graphs space
   */
  public float numx(float pix) {
    return xmin + pix/pxpnx;
  }
  
  /**
   * This method converts a numerical value of y to a pixel
   * @param orig the numerical coordinate to be ploted
   * @return the pixel coordinated to that number
   */
   public float pixely(float num) {
     return (ymax-num)*pypny;
   }
   
   /**
    * This method converts a pixel value in y to a numerical value
    * @param pix the y pixel value
    * @return the numerical y value associated with that pixel
    */
    public float numy(float pix) {
      return ymax - pix/pypny;
    }
   
   /**
    * This function draws the axis of the graph.
    * These are graphed with a numerical spacing defined by the tick-marks.
    * If the tick marks are equivalent to zero, no markings are displayed
    * FIXME - if the axis isn't within the window, draws the tickmarks on edge
    */
    public void drawAxis(boolean ticks) {
      line(xzero, 0, xzero, ylim);
      line(0, yzero, xlim, yzero);
      
      // Draws ticks if needed.
      if (ticks) {
        drawTicks();
      }
    }
    
    /**
     * Helper method that draws ticks at the specified intervals
     */
    private void drawTicks() {
      if (xtick > 0) {
        float curx = xzero;
        while (curx < xlim) {
          curx += xtick*pxpnx;
          line(curx, yzero + 0.02*ylim, curx, yzero - 0.02*ylim);
        }
        curx = xzero;
        while (curx > 0) {
          curx -= xtick*pxpnx;
          line(curx, yzero + 0.02*ylim, curx, yzero - 0.02*ylim);
        }
      }
      if (ytick > 0) {
        float cury = yzero;
        while (cury > 0) {
          cury -= ytick*pypny;
          line(xzero - 0.02*xlim, cury, xzero + 0.02*xlim, cury);
        }
        cury = yzero;
        while (cury < ylim) {
          cury += ytick*pypny;
          line(xzero - 0.02*xlim, cury, xzero + 0.02*xlim, cury);
        }
      }
    }
}
