package ChiselRISC.utilities

import java.io.File
import java.nio.file.{Files, Paths}

object Binary {
  def loadWords(path: String): Seq[BigInt] = {
    Files.readAllBytes(Paths.get(path))
      .map(BigInt(_) & 0xFF)
      .grouped(4)
      .map(a => a(0) | (a(1) << 8) | (a(2) << 16) | (a(3) << 24))
      .toSeq
  }
}