`timescale 1ns / 1ps

module sram_async_read_tb;

	// Inputs
	reg clk;
	reg write_en;
	reg [7:0] data_in;
	reg [3:0] address;

	// Outputs
	wire [7:0] data_out;
	reg [1:0] delay;
	reg [7:0]wr_data;
	integer success_count,error_count,test_count;
	integer i;

	// Instantiate the Unit Under Test (UUT)
	sram_async_read uut (
		.clk(clk), 
		.write_en(write_en), 
		.data_in(data_in), 
		.address(address), 
		.data_out(data_out)
	);
	task write_data(input [3:0]address_in,input [7:0]d_in);
	begin
	write_en=1;
	address=address_in;
	data_in=d_in;
	@(posedge clk)
	write_en=0;
	end
	endtask
	task read_data(input [3:0] address_in);
	begin
	write_en=0;
	address=address_in;
	end
	endtask
	task compare_data(input [3:0] address, input [7:0] expected_data, input [7:0] observed_data);
begin
	if (expected_data === observed_data) begin
		$display($time ," SUCCESS: address=%0d, expected_data=%2x , observed_data=%2x", address, expected_data, observed_data);
		success_count = success_count + 1;
	end else begin
		$display($time ," ERROR:   address=%0d, expected_data=%2x , observed_data=%2x", address, expected_data, observed_data);
		error_count = error_count + 1;
	end
	test_count = test_count + 1;
end
endtask

	
	initial clk=0;
	always #5 clk=~clk;
	initial begin
	success_count=0;test_count=0;error_count=0;
	for(i=0;i<15;i=i+1) begin
	wr_data=$random;
	write_data(i,wr_data);
	read_data(i);
	#2;
	compare_data(i,wr_data,data_out);
	delay=$random;
   #delay;
end
read_data(7);
read_data(0);

$display($time, "TEST RESULT SUCCESS_COUNT=%2d, error_count=%2d, test_count=%2d",success_count,error_count,test_count);
#300 $stop;
end
      
endmodule

