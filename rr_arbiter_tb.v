module rr_arbiter_tb;
    // Signals declaration
    reg clk;
    reg rst;
    reg [1:0] req;
    wire [1:0] grant;
    
    // Instantiate the round-robin arbiter
    rr_arbiter dut (
        .clk(clk),
        .rst(rst),
        .req(req),
        .grant(grant)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test stimulus
    initial begin
        // Initialize
        rst = 1;
        req = 2'b00;
        
        // Wait for 2 clock cycles and release reset
        #20;
        rst = 0;
        
        // Test case 1: Single request
        #10 req = 2'b01;  // Request from port 0
        #10 req = 2'b10;  // Request from port 1
        
        // Test case 2: Multiple simultaneous requests
        #10 req = 2'b11;  // Both ports requesting
        
        // Test case 3: No requests
        #10 req = 2'b00;
        
        // Test case 4: Alternating requests
        #10 req = 2'b01;
        #10 req = 2'b10;
        #10 req = 2'b01;
        
        // Test case 5: Reset during operation
        #10 rst = 1;
        #10 rst = 0;
        
        // Run for a few more cycles and finish
        #50;
        $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time=%0t rst=%b req=%b grant=%b last=%b", 
                 $time, rst, req, grant, dut.last);
    end
    
    // Optional waveform generation
    initial begin
        $dumpfile("rr_arbiter.vcd");
        $dumpvars(0, rr_arbiter_tb);
    end
    
endmodule
