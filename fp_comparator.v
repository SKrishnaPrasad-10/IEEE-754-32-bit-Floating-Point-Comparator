typedef enum logic [1:0] { A_LESS_THAN_B = 2'b00, A_GREATER_THAN_B = 2'b01, A_EQUALS_B = 2'b10, INVALID_INPUTS = 2'b11 } compare;

module fp_comparator(A, B, result);
  input logic [31:0] A;
  input logic [31:0] B;
  output compare result; // result is of compare type
  

  reg sign1, sign2; // 1-bit sign
  reg [7:0] exp1, exp2; // 8-bit biased exponent
  reg [22:0] man1, man2; // 23-bit mantissa

  // Un-pack the inputs into their respective sign, mantissa and mantissa parts
  assign sign1 = A[31];
  assign exp1 = A[30:23];
  assign man1 = A[22:0];
  
  assign sign2 = B[31];
  assign exp2 = B[30:23];
  assign man2 = B[22:0];

  always @(*) begin
    if(exp1 == 255 || exp2 == 255) // Detect NaN(Not a Number) & Infinity input cases
      result = INVALID_INPUTS; 
    else if( A[30:0] == 0 && B[30:0] == 0) // Detect +ve and -ve Zero inputs
      result = A_EQUALS_B;
    else begin
      case ({sign1, sign2})
        2'b00: if(exp1 > exp2) result = A_GREATER_THAN_B;
               else if(exp1 < exp2) result = A_LESS_THAN_B;
               else if(exp1 == exp2) begin
                 if(man1 > man2) result = A_GREATER_THAN_B;
                 else if(man1 < man2) result = A_LESS_THAN_B;
                 else if(man1 == man2) result = A_EQUALS_B;
               end
        2'b01: result = A_GREATER_THAN_B; 
        2'b10: result = A_LESS_THAN_B;
        2'b11: if(exp1 > exp2) result = A_LESS_THAN_B;
               else if(exp1 < exp2) result = A_GREATER_THAN_B;
               else if(exp1 == exp2) begin
                 if(man1 > man2) result = A_LESS_THAN_B;
                 else if(man1 < man2) result = A_GREATER_THAN_B;
                 else if(man1 == man2) result = A_EQUALS_B;
               end
        default: result = INVALID_INPUTS;
      endcase
    end
  end
endmodule
