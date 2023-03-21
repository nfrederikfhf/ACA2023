package stages
import chisel3._
import chisel3.util._
import components._

class IF(datawidth: Int) extends Module{
  val io = IO(new Bundle {
    val inst = Decoupled(UInt(datawidth.W))
    val
  })

}
