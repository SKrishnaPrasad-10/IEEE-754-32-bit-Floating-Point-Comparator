module tb_comp();
  reg [31:0] A;
  reg [31:0] B;
  compare result; // result is of compare type

  fp_comparator cmp(.A(A), .B(B), .result(result)); //DUT Instance

  // Test cases
  initial begin
    A = 32'h41200000; // A > B, both +ve A=10, B=1
    B = 32'h3F800000;
    #1; $display("A = %0h , B = %0h, Expected: A_GREATER_THAN_B \t Actual: %s ", A, B,result.name());

    A = 32'h44806000; // A < B, both +ve A = 1027 B = 8239
    B = 32'h4600BC00;
    #1; $display("A = %0h , B = %0h, Expected: A_LESS_THAN_B \t Actual: %s ", A, B,result.name());

    A = 32'h2BCDEFFF; // A = B, both +ve  A = 1.4632738e-12
    B = 32'h2BCDEFFF;
    #1; $display("A = %0h , B = %0h, Expected: A_EQUALS_B \t Actual: %s ", A, B,result.name());
    
    A = 32'hC5AFFA2C; // A < B, both -ve; A=-5631.2714, B=-96.726
    B = 32'hC2C173B6;
    #1; $display("A = %0h , B = %0h, Expected: A_LESS_THAN_B \t Actual: %s ", A, B,result.name());

    A = 32'hBF801911; // A > B, both -ve; A = -1.000765 B=-97239.72
    B = 32'hC7BDEBDC;
    #1; $display("A = %0h , B = %0h, Expected: A_GREATER_THAN_B \t Actual: %s ", A, B,result.name());

    A = 32'h000028FC; // A = B, both -ve; A = 1.4702e-41
    B = 32'h000028FC;
    #1; $display("A = %0h , B = %0h, Expected: A_EQUALS_B \t Actual: %s ", A, B,result.name());

    A = 32'h558A9000; // A > B, opposite signs; A = 19043884990464,  B=-0.00006712
    B = 32'hB88CC2C7;
    #1; $display("A = %0h , B = %0h, Expected: A_GREATER_THAN_B \t Actual: %s ", A, B,result.name());

    A = 32'hC435C1E7; // A < B, opposite signs; A = -727.0297,  B=3.14
    B = 32'h4048F5C3;
    #1; $display("A = %0h , B = %0h, Expected: A_LESS_THAN_B \t Actual: %s ", A, B,result.name());
    
    A = 32'h00000000; B = 32'hC7BDEBDC; // A = Zero & B < 0
    #1; $display("A = %0h , B = %0h, Expected: A_GREATER_THAN_B \t Actual: %s ", A, B,result.name());
    
    A = 32'h3F800000; // A = 1 , B = 2
    B = 32'h40000000;
    #1; $display("A = %0h , B = %0h, Expected: A_LESS_THAN_B \t Actual: %s ", A, B,result.name());
    
    A = 32'h7f7fffff; // A = 3.40282347e+38 (maximum normal number)
    B = 32'h00800000; // B = 1.17549435e-38 (minimum positive normal number)
    #1; $display("A = %0h , B = %0h, Expected: A_GREATER_THAN_B \t Actual: %s ", A, B,result.name());
    
    A = 32'h007fffff; // A = 1.17549421e-38 (maximum subnormal number)
    B = 32'h00000001; // B = 1.40129846e-45 (minimum positive subnormal number)
    #1; $display("A = %0h , B = %0h, Expected: A_GREATER_THAN_B \t Actual: %s ", A, B,result.name());
    
    B = 32'h7F800000; // A = Infinity
    #1; $display("A = %0h , B = %0h, Expected: INVALID_INPUTS \t Actual: %s ", A, B,result.name());

    A = 32'hFF800000; // A = -Infinity
    #1; $display("A = %0h , B = %0h, Expected: INVALID_INPUTS \t Actual: %s ", A, B,result.name());
    
    A = 32'h7EFFFFFF; // A = 1.7014117e+38
    B = 32'h7E967699; // B = 9.9999996e+37
    #1; $display("A = %0h , B = %0h, Expected: A_GREATER_THAN_B \t Actual: %s ", A, B,result.name());
    
    A = 32'h00000000; B = 32'h80000000; // +ve & -ve Zero values
    #1; $display("A = %0h , B = %0h, Expected: A_EQUALS_B \t Actual: %s ", A, B,result.name());
    
    B = 32'hFFF12346; // Testcase for Invalid A = NaN
    #1; $display("A = %0h , B = %0h, Expected: INVALID_INPUTS \t Actual: %s ", A, B,result.name());

    $finish;
  end
endmodule
