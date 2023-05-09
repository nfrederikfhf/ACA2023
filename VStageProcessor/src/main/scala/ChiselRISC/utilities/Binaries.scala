package ChiselRISC.utilities

import java.io.File
import java.nio.file.{Files, Paths}

object Binaries {
/*
  Based on the method supplied by Tjark Petersen the TA for course 02221 at DTU
  https://github.com/pluto-platform/pluto/blob/master/src/main/scala/lib/Binaries.scala
  It is used for loading the binary files into the instruction memory.
 */
  def loadWords(path: String): Seq[BigInt] = {
    Files.readAllBytes(Paths.get(path))
      .map(BigInt(_) & 0xFF)
      .grouped(4)
      .map(a => a(0) | (a(1) << 8) | (a(2) << 16) | (a(3) << 24))
      .toSeq
  }
}
