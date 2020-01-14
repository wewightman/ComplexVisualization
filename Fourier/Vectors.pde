class Arrow {
  private float[] coords = new float[2];
  private float[] unit = new float[2];
  private float[] head = new float[6];
  private float mag;
  private int rgb;
  
  public Arrow(float[] coords, float[] unit, float mag, int rgb) {
    if (coords.length != unit.length) {
      throw new IllegalArgumentException("Coordinates and direction not defined with same dinensions");
    }
    if (coords.length != 2) {
      throw new IllegalArgumentException("Vectors must be defined in only two dimensions");
    }
    
    this.coords = coords;
    this.unit = unit;
    this.mag = mag;
    this.head = updateHead();
    this.rgb = rgb;
  }
  
  public Arrow(float[] root, float[] tip) {
    this.coords = root;
    this.rgb = 0;
    this.setEnd(tip[0],tip[1]);
  }
  
  // Calculates the corners of the head of the triangle
  private float[] updateHead() {
    head[0] = coords[0] + unit[0]*mag;
    head[1] = coords[1] + unit[1]*mag;
    
    float[] base = {(coords[0]+0.8*unit[0]*mag), (coords[1]+0.8*unit[1]*mag)};
    
    head[2] = base[0] - 0.1*mag*unit[1];
    head[3] = base[1] + 0.1*mag*unit[0];
    head[4] = base[0] + 0.1*mag*unit[1];
    head[5] = base[1] - 0.1*mag*unit[0];
    
    return head;
  }
  
   public void draw(){
     line(coords[0],coords[1], coords[0] + mag*unit[0], coords[1] + mag*unit[1]);
     updateHead();
     triangle(head[0], head[1], head[2], head[3], head[4], head[5]);
     fill(rgb);
   }
   
   public void drawUnit(Graph graph) {
     float[] transBase = {graph.pixelx(coords[0]), graph.pixely(coords[1])};
     float[] transHead = {graph.pixelx(coords[0] + unit[0]), graph.pixely(coords[1] + unit[1])};
     new Arrow(transBase, transHead).draw();
   }
   
   public void draw(Graph graph) {
     float[] transBase = {graph.pixelx(coords[0]), graph.pixely(coords[1])};
     float[] transHead = {graph.pixelx(coords[0] + mag*unit[0]), graph.pixely(coords[1] + mag*unit[1])};
     new Arrow(transBase, transHead).draw();
   }
   
   public void setUnit(float[] unit){
     this.unit = unit;
   }
   
   public void setMag(float mag) {
     this.mag = mag;
     head[0] = unit[0]*mag;
     head[1] = unit[1]*mag;
   }
   
   public void setEnd (float xco, float yco) {
     float dx = xco - coords[0];
     float dy = yco - coords[1];
     this.mag = (float)Math.sqrt(dx*dx + dy*dy);
     
     this.unit = new float[]{dx/this.mag, dy/this.mag};
   }
}
