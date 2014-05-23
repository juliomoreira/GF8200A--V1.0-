DefinitionBlock ("dsdt.aml", "DSDT", 1, "1AAAA", "1AAAA000", 0x00000000)
{
    Name (DP80, 0x80)
    Name (DP90, 0x90)
    Name (SPIO, 0x2E)
    Name (IOSB, 0x0A00)
    Name (IOSL, 0x10)
    Name (IOHB, 0x0A10)
    Name (IOHL, 0x10)
    Name (SSMI, 0x242E)
    Name (APIC, One)
    Name (SHPB, 0xFED00000)
    Name (SHPL, 0x1000)
    Name (GPBS, 0x24C0)
    Name (PMBS, 0x2000)
    Name (PMLN, 0x0100)
    Name (SCBS, 0x2400)
    Name (SCLN, 0x0100)
    Name (ACBS, 0x2800)
    Name (ACLN, 0x0100)
    Name (MTAB, 0x2F00)
    Name (MTAL, 0x0100)
    Name (ACA4, 0x20A4)
    Name (SCIO, 0x2400)
    Name (SCTL, 0x2090)
    Name (SNAS, One)
    Name (SNAM, 0xFED04000)
    Name (SNAL, 0x1000)
    Name (SPAS, Zero)
    Name (SPAM, Zero)
    Name (SPAL, Zero)
    Name (MUAE, Zero)
    Name (PCIB, 0xE0000000)
    Name (PCIL, 0x10000000)
    Name (PEHP, Zero)
    Name (SHPC, Zero)
    Name (PEPM, One)
    Name (PEER, One)
    Name (PECS, Zero)
    Name (WKTP, One)
    Name (HDCP, One)
    OperationRegion (BIOS, SystemMemory, 0xDFFBE064, 0xFF)
    Field (BIOS, ByteAcc, NoLock, Preserve)
    {
        SS1,    1, 
        SS2,    1, 
        SS3,    1, 
        SS4,    1, 
        Offset (0x01), 
        IOST,   16, 
        TOPM,   32, 
        ROMS,   32, 
        MG1B,   32, 
        MG1L,   32, 
        MG2B,   32, 
        MG2L,   32, 
        Offset (0x1C), 
        DMAX,   8, 
        HPTA,   32, 
        CPB0,   32, 
        CPB1,   32, 
        CPB2,   32, 
        CPB3,   32, 
        ASSB,   8, 
        AOTB,   8, 
        AAXB,   32, 
        SMIF,   8, 
        DTSE,   8, 
        DTS1,   8, 
        DTS2,   8, 
        MPEN,   8, 
        TPMF,   8, 
        MG3B,   32, 
        MG3L,   32, 
        MH1B,   32, 
        MH1L,   32, 
        OSTP,   8, 
        HYCM,   8
    }
    Method (RRIO, 4, NotSerialized)
    {
        Store ("RRIO", Debug)
    }
    Method (RDMA, 3, NotSerialized)
    {
        Store ("rDMA", Debug)
    }
    Name (PICM, Zero)
    Method (_PIC, 1, NotSerialized)
    {
        If (Arg0)
        {
            Store (0xAA, DBG8)
        }
        Else
        {
            Store (0xAC, DBG8)
        }
        Store (Arg0, PICM)
    }
    Name (OSVR, Ones)
    Method (OSFL, 0, NotSerialized)
    {
        If (LNotEqual (OSVR, Ones))
        {
            Return (OSVR)
        }
        Name (TTT0, Zero)
        Store (OSYS (), TTT0)
        If (LEqual (TTT0, One))
        {
            Store (0x03, OSVR)
        }
        Else
        {
            If (LEqual (TTT0, 0x10))
            {
                Store (One, OSVR)
            }
            Else
            {
                If (LEqual (TTT0, 0x11))
                {
                    Store (0x02, OSVR)
                }
                Else
                {
                    If (LEqual (TTT0, 0x12))
                    {
                        Store (0x04, OSVR)
                    }
                    Else
                    {
                        If (LEqual (TTT0, 0x13))
                        {
                            Store (Zero, OSVR)
                        }
                        Else
                        {
                            If (LEqual (TTT0, 0x14))
                            {
                                Store (Zero, OSVR)
                            }
                            Else
                            {
                                If (LEqual (TTT0, 0x15))
                                {
                                    Store (Zero, OSVR)
                                }
                            }
                        }
                    }
                }
            }
        }
        Return (OSVR)
    }
    Method (MCTH, 2, NotSerialized)
    {
        If (LLess (SizeOf (Arg0), SizeOf (Arg1)))
        {
            Return (Zero)
        }
        Add (SizeOf (Arg0), One, Local0)
        Name (BUF0, Buffer (Local0) {})
        Name (BUF1, Buffer (Local0) {})
        Store (Arg0, BUF0)
        Store (Arg1, BUF1)
        While (Local0)
        {
            Decrement (Local0)
            If (LNotEqual (DerefOf (Index (BUF0, Local0)), DerefOf (Index (
                BUF1, Local0))))
            {
                Return (Zero)
            }
        }
        Return (One)
    }
    Name (PRWP, Package (0x02)
    {
        Zero, 
        Zero
    })
    Method (GPRW, 2, NotSerialized)
    {
        Store (Arg0, Index (PRWP, Zero))
        Store (ShiftLeft (SS1, One), Local0)
        Or (Local0, ShiftLeft (SS2, 0x02), Local0)
        Or (Local0, ShiftLeft (SS3, 0x03), Local0)
        Or (Local0, ShiftLeft (SS4, 0x04), Local0)
        If (And (ShiftLeft (One, Arg1), Local0))
        {
            Store (Arg1, Index (PRWP, One))
        }
        Else
        {
            ShiftRight (Local0, One, Local0)
            If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
            {
                FindSetLeftBit (Local0, Index (PRWP, One))
            }
            Else
            {
                FindSetRightBit (Local0, Index (PRWP, One))
            }
        }
        Return (PRWP)
    }
    Name (WAKP, Package (0x02)
    {
        Zero, 
        Zero
    })
    OperationRegion (DEB0, SystemIO, DP80, One)
    Field (DEB0, ByteAcc, NoLock, Preserve)
    {
        DBG8,   8
    }
    OperationRegion (DEB1, SystemIO, DP90, 0x02)
    Field (DEB1, WordAcc, NoLock, Preserve)
    {
        DBG9,   16
    }
    Method (OSYS, 0, NotSerialized)
    {
        Store (0x15, Local0)
        Return (Local0)
    }
    Scope (_PR)
    {
        Processor (P001, 0x01, 0x00002010, 0x06)
        {
        }
        Processor (P002, 0x02, 0x00000000, 0x00)
        {
        }
        Processor (P003, 0x03, 0x00000000, 0x00)
        {
        }
        Processor (P004, 0x04, 0x00000000, 0x00)
        {
        }
        Processor (P005, 0x05, 0x00000000, 0x00)
        {
        }
        Processor (P006, 0x06, 0x00000000, 0x00)
        {
        }
        Alias (P001, CPU1)
        Alias (P002, CPU2)
        Alias (P003, CPU3)
        Alias (P004, CPU4)
        Alias (P005, CPU5)
        Alias (P006, CPU6)
    }
    Scope (_SB)
    {
        Name (PR00, Package (0x2A)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LSMB, 
                Zero
            }, 
            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LPMU, 
                Zero
            }, 
            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LUB0, 
                Zero
            }, 
            Package (0x04)
            {
                0x0002FFFF, 
                One, 
                LUB2, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                UB11, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                One, 
                UB12, 
                Zero
            }, 
            Package (0x04)
            {
                0x000AFFFF, 
                Zero, 
                LMAC, 
                Zero
            }, 
            Package (0x04)
            {
                0x0009FFFF, 
                Zero, 
                LSA0, 
                Zero
            }, 
            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                LAZA, 
                Zero
            }, 
            Package (0x04)
            {
                0x000BFFFF, 
                Zero, 
                SGRU, 
                Zero
            }, 
            Package (0x04)
            {
                0x0010FFFF, 
                Zero, 
                LN0A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0010FFFF, 
                One, 
                LN0B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0010FFFF, 
                0x02, 
                LN0C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0010FFFF, 
                0x03, 
                LN0D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0011FFFF, 
                Zero, 
                LN1A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0011FFFF, 
                One, 
                LN1B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0011FFFF, 
                0x02, 
                LN1C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0011FFFF, 
                0x03, 
                LN1D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0012FFFF, 
                Zero, 
                LN2A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0012FFFF, 
                One, 
                LN2B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0012FFFF, 
                0x02, 
                LN2C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0012FFFF, 
                0x03, 
                LN2D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0013FFFF, 
                Zero, 
                LN3A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0013FFFF, 
                One, 
                LN3B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0013FFFF, 
                0x02, 
                LN3C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0013FFFF, 
                0x03, 
                LN3D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0014FFFF, 
                Zero, 
                LN4A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0014FFFF, 
                One, 
                LN4B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0014FFFF, 
                0x02, 
                LN4C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0014FFFF, 
                0x03, 
                LN4D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0015FFFF, 
                Zero, 
                LN5A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0015FFFF, 
                One, 
                LN5B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0015FFFF, 
                0x02, 
                LN5C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0015FFFF, 
                0x03, 
                LN5D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0016FFFF, 
                Zero, 
                LN6A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0016FFFF, 
                One, 
                LN6B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0016FFFF, 
                0x02, 
                LN6C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0016FFFF, 
                0x03, 
                LN6D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0017FFFF, 
                Zero, 
                LN7A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0017FFFF, 
                One, 
                LN7B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0017FFFF, 
                0x02, 
                LN7C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0017FFFF, 
                0x03, 
                LN7D, 
                Zero
            }
        })
        Name (AR00, Package (0x2A)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LSMB, 
                Zero
            }, 
            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LPMU, 
                Zero
            }, 
            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LUB0, 
                Zero
            }, 
            Package (0x04)
            {
                0x0002FFFF, 
                One, 
                LUB2, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                UB11, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                One, 
                UB12, 
                Zero
            }, 
            Package (0x04)
            {
                0x000AFFFF, 
                Zero, 
                LMAC, 
                Zero
            }, 
            Package (0x04)
            {
                0x0009FFFF, 
                Zero, 
                LSA0, 
                Zero
            }, 
            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                LAZA, 
                Zero
            }, 
            Package (0x04)
            {
                0x000BFFFF, 
                Zero, 
                SGRU, 
                Zero
            }, 
            Package (0x04)
            {
                0x0010FFFF, 
                Zero, 
                LN0A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0010FFFF, 
                One, 
                LN0B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0010FFFF, 
                0x02, 
                LN0C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0010FFFF, 
                0x03, 
                LN0D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0011FFFF, 
                Zero, 
                LN1A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0011FFFF, 
                One, 
                LN1B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0011FFFF, 
                0x02, 
                LN1C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0011FFFF, 
                0x03, 
                LN1D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0012FFFF, 
                Zero, 
                LN2A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0012FFFF, 
                One, 
                LN2B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0012FFFF, 
                0x02, 
                LN2C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0012FFFF, 
                0x03, 
                LN2D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0013FFFF, 
                Zero, 
                LN3A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0013FFFF, 
                One, 
                LN3B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0013FFFF, 
                0x02, 
                LN3C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0013FFFF, 
                0x03, 
                LN3D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0014FFFF, 
                Zero, 
                LN4A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0014FFFF, 
                One, 
                LN4B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0014FFFF, 
                0x02, 
                LN4C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0014FFFF, 
                0x03, 
                LN4D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0015FFFF, 
                Zero, 
                LN5A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0015FFFF, 
                One, 
                LN5B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0015FFFF, 
                0x02, 
                LN5C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0015FFFF, 
                0x03, 
                LN5D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0016FFFF, 
                Zero, 
                LN6A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0016FFFF, 
                One, 
                LN6B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0016FFFF, 
                0x02, 
                LN6C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0016FFFF, 
                0x03, 
                LN6D, 
                Zero
            }, 
            Package (0x04)
            {
                0x0017FFFF, 
                Zero, 
                LN7A, 
                Zero
            }, 
            Package (0x04)
            {
                0x0017FFFF, 
                One, 
                LN7B, 
                Zero
            }, 
            Package (0x04)
            {
                0x0017FFFF, 
                0x02, 
                LN7C, 
                Zero
            }, 
            Package (0x04)
            {
                0x0017FFFF, 
                0x03, 
                LN7D, 
                Zero
            }
        })
        Name (PR02, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                SGRU, 
                Zero
            }
        })
        Name (AR02, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                SGRU, 
                Zero
            }
        })
        Name (PR10, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN0A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN0B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN0C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN0D, 
                Zero
            }
        })
        Name (AR10, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN0A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN0B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN0C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN0D, 
                Zero
            }
        })
        Name (PR11, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN1A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN1B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN1C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN1D, 
                Zero
            }
        })
        Name (AR11, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN1A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN1B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN1C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN1D, 
                Zero
            }
        })
        Name (PR12, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN2A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN2B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN2C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN2D, 
                Zero
            }
        })
        Name (AR12, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN2A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN2B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN2C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN2D, 
                Zero
            }
        })
        Name (PR13, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN3A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN3B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN3C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN3D, 
                Zero
            }
        })
        Name (AR13, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN3A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN3B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN3C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN3D, 
                Zero
            }
        })
        Name (PR14, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN4A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN4B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN4C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN4D, 
                Zero
            }
        })
        Name (AR14, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN4A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN4B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN4C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN4D, 
                Zero
            }
        })
        Name (PR15, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN5A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN5B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN5C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN5D, 
                Zero
            }
        })
        Name (AR15, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN5A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN5B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN5C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN5D, 
                Zero
            }
        })
        Name (PR16, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN6A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN6B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN6C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN6D, 
                Zero
            }
        })
        Name (AR16, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN6A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN6B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN6C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN6D, 
                Zero
            }
        })
        Name (PR17, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN7A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN7B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN7C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN7D, 
                Zero
            }
        })
        Name (AR17, Package (0x04)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LN7A, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                One, 
                LN7B, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LN7C, 
                Zero
            }, 
            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LN7D, 
                Zero
            }
        })
        Name (PR01, Package (0x0C)
        {
            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                One, 
                LNKB, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 
            Package (0x04)
            {
                0x0005FFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 
            Package (0x04)
            {
                0x0005FFFF, 
                One, 
                LNKC, 
                Zero
            }, 
            Package (0x04)
            {
                0x0005FFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 
            Package (0x04)
            {
                0x0005FFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 
            Package (0x04)
            {
                0x0006FFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 
            Package (0x04)
            {
                0x0006FFFF, 
                One, 
                LNKD, 
                Zero
            }, 
            Package (0x04)
            {
                0x0006FFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 
            Package (0x04)
            {
                0x0006FFFF, 
                0x03, 
                LNKB, 
                Zero
            }
        })
        Name (AR01, Package (0x0C)
        {
            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                One, 
                LNKB, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 
            Package (0x04)
            {
                0x0004FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 
            Package (0x04)
            {
                0x0005FFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 
            Package (0x04)
            {
                0x0005FFFF, 
                One, 
                LNKC, 
                Zero
            }, 
            Package (0x04)
            {
                0x0005FFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 
            Package (0x04)
            {
                0x0005FFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 
            Package (0x04)
            {
                0x0006FFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 
            Package (0x04)
            {
                0x0006FFFF, 
                One, 
                LNKD, 
                Zero
            }, 
            Package (0x04)
            {
                0x0006FFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 
            Package (0x04)
            {
                0x0006FFFF, 
                0x03, 
                LNKB, 
                Zero
            }
        })
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {7,10,11,14,15}
        })
        Alias (PRSA, PRSB)
        Alias (PRSA, PRSC)
        Alias (PRSA, PRSD)
        Alias (PRSA, RS0A)
        Alias (PRSA, RS0B)
        Alias (PRSA, RS0C)
        Alias (PRSA, RS0D)
        Alias (PRSA, RS1A)
        Alias (PRSA, RS1B)
        Alias (PRSA, RS1C)
        Alias (PRSA, RS1D)
        Alias (PRSA, RS2A)
        Alias (PRSA, RS2B)
        Alias (PRSA, RS2C)
        Alias (PRSA, RS2D)
        Alias (PRSA, RS3A)
        Alias (PRSA, RS3B)
        Alias (PRSA, RS3C)
        Alias (PRSA, RS3D)
        Alias (PRSA, RS4A)
        Alias (PRSA, RS4B)
        Alias (PRSA, RS4C)
        Alias (PRSA, RS4D)
        Alias (PRSA, RS5A)
        Alias (PRSA, RS5B)
        Alias (PRSA, RS5C)
        Alias (PRSA, RS5D)
        Alias (PRSA, RS6A)
        Alias (PRSA, RS6B)
        Alias (PRSA, RS6C)
        Alias (PRSA, RS6D)
        Alias (PRSA, RS7A)
        Alias (PRSA, RS7B)
        Alias (PRSA, RS7C)
        Alias (PRSA, RS7D)
        Name (RSA0, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5}
        })
        Alias (PRSA, RSAC)
        Alias (PRSA, RSB0)
        Alias (PRSA, RSB2)
        Alias (PRSA, RS11)
        Alias (PRSA, RS12)
        Alias (PRSA, RSMB)
        Alias (PRSA, RSMU)
        Alias (PRSA, RSZA)
        Alias (PRSA, RSRU)
        Alias (PRSA, RSTA)
        Name (RSIR, ResourceTemplate ()
        {
            Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
            {
                0x00000010,
                0x00000011,
                0x00000012,
                0x00000013,
            }
        })
        Name (RSII, ResourceTemplate ()
        {
            Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
            {
                0x00000014,
                0x00000015,
                0x00000016,
                0x00000017,
            }
        })
        Alias (RSII, RSIG)
        Alias (RSII, RSU1)
        Alias (RSII, RSU2)
        Alias (RSII, RSI1)
        Alias (RSII, RSI2)
        Alias (RSII, RSSA)
        Alias (RSII, RSMA)
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00180000)
            Method (^BN00, 0, NotSerialized)
            {
                Return (Zero)
            }
            Method (_BBN, 0, NotSerialized)
            {
                Return (BN00 ())
            }
            Name (_UID, Zero)
            Method (_PRT, 0, NotSerialized)
            {
                If (PICM)
                {
                    Return (AR00)
                }
                Return (PR00)
            }
            Method (NPTS, 1, NotSerialized)
            {
            }
            Method (NWAK, 1, NotSerialized)
            {
            }
            Device (SBRG)
            {
                Name (_ADR, 0x00010000)
                Method (SPTS, 1, NotSerialized)
                {
                    Store (One, PS1S)
                    Store (One, PS1E)
                }
                Method (SWAK, 1, NotSerialized)
                {
                    Store (Zero, PS1E)
                    Store (0x02, S1CT)
                    Store (0x02, S3CT)
                    Store (0x02, S4CT)
                    Store (0x02, S5CT)
                }
                OperationRegion (SMIE, SystemIO, SCIO, 0x08)
                Field (SMIE, ByteAcc, NoLock, Preserve)
                {
                        ,   15, 
                    PS1S,   1, 
                        ,   31, 
                    PS1E,   1, 
                    Offset (0x08)
                }
                OperationRegion (SXCT, SystemIO, SCTL, 0x10)
                Field (SXCT, ByteAcc, NoLock, Preserve)
                {
                    S1CT,   2, 
                    Offset (0x04), 
                    S3CT,   2, 
                    Offset (0x08), 
                    S4CT,   2, 
                    Offset (0x0C), 
                    S5CT,   2, 
                    Offset (0x10)
                }
                OperationRegion (GPB0, SystemIO, GPBS, 0x28)
                Field (GPB0, ByteAcc, NoLock, Preserve)
                {
                    GP01,   8, 
                    GP02,   8, 
                    GP03,   8, 
                    GP04,   8, 
                    GP05,   8, 
                    GP06,   8, 
                    GP07,   8, 
                    GP08,   8, 
                    GP09,   8, 
                    GP10,   8, 
                    GP11,   8, 
                    GP12,   8, 
                    GP13,   8, 
                    GP14,   8, 
                    GP15,   8, 
                    GP16,   8, 
                    GP17,   8, 
                    GP18,   8, 
                    GP19,   8, 
                    GP20,   8, 
                    GP21,   8, 
                    GP22,   8, 
                    GP23,   8, 
                    GP24,   8, 
                    GP25,   8, 
                    GP26,   8, 
                    GP27,   8, 
                    GP28,   8, 
                    GP29,   8, 
                    GP30,   8, 
                    GP31,   8, 
                    GP32,   8, 
                    GP33,   8, 
                    GP34,   8, 
                    GP35,   8, 
                    GP36,   8, 
                    GP37,   8, 
                    GP38,   8, 
                    GP39,   8, 
                    GP40,   8
                }
                OperationRegion (MM90, SystemMemory, 0xE0080000, 0xFF)
                Field (MM90, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x90), 
                        ,   4, 
                    CSLD,   1, 
                        ,   22, 
                    CSLT,   1, 
                        ,   1, 
                    SDLA,   1
                }
                OperationRegion (RTCO, SystemIO, 0x72, 0x02)
                Field (RTCO, ByteAcc, NoLock, Preserve)
                {
                    CIND,   8, 
                    CDAT,   8
                }
                IndexField (CIND, CDAT, ByteAcc, NoLock, Preserve)
                {
                    Offset (0xD0), 
                    CMO1,   4
                }
                Scope (\_SB)
                {
                    OperationRegion (\SCPP, SystemIO, SSMI, One)
                    Field (SCPP, ByteAcc, NoLock, Preserve)
                    {
                        SMIP,   8
                    }
                    Scope (PCI0)
                    {
                        Method (_S3D, 0, NotSerialized)
                        {
                            If (LEqual (OSFL (), 0x02))
                            {
                                Return (0x02)
                            }
                            Else
                            {
                                Return (0x03)
                            }
                        }
                        Name (_S1D, One)
                        Name (NATA, Package (0x01)
                        {
                            0x00090000
                        })
                        Device (NVRB)
                        {
                            Name (_HID, "NVRD0001")
                            Name (FNVR, 0xFF)
                            Method (_DIS, 0, NotSerialized)
                            {
                                Store (Zero, FNVR)
                            }
                            Method (_SRS, 1, NotSerialized)
                            {
                                Store (0xFF, FNVR)
                            }
                            Method (_STA, 0, NotSerialized)
                            {
                                If (And (CPB0, One))
                                {
                                    If (LEqual (FNVR, 0xFF))
                                    {
                                        Return (0x0F)
                                    }
                                    Else
                                    {
                                        Return (0x0D)
                                    }
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }
                            Name (_CRS, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x04D2,             // Range Minimum
                                    0x04D2,             // Range Maximum
                                    0x01,               // Alignment
                                    0x01,               // Length
                                    )
                            })
                        }
                    }
                }
                OperationRegion (UCFG, PCI_Config, 0x78, One)
                Field (UCFG, ByteAcc, NoLock, Preserve)
                {
                    U1CF,   8
                }
                Device (MUAR)
                {
                    Name (_UID, 0xFF)
                    Name (_HID, EisaId ("PNP0501"))
                    Method (_STA, 0, NotSerialized)
                    {
                        If (MUAE)
                        {
                            And (U1CF, 0x83, Local0)
                            If (LEqual (Local0, 0x82))
                            {
                                Return (0x0F)
                            }
                        }
                        Return (Zero)
                    }
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (LEqual (U1CF, 0xC2))
                        {
                            Store (0x03F8, UIO1)
                            ShiftLeft (One, 0x04, UIRQ)
                            Store (One, _UID)
                        }
                        If (LEqual (U1CF, 0xA6))
                        {
                            Store (0x02F8, UIO1)
                            ShiftLeft (One, 0x03, UIRQ)
                            Store (0x02, _UID)
                        }
                        Store (UIO1, UIO2)
                        Return (UCRS)
                    }
                    Name (UCRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            _Y01)
                        IRQNoFlags (_Y00)
                            {}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {}
                    })
                    CreateWordField (UCRS, \_SB.PCI0.SBRG.MUAR._Y00._INT, UIRQ)
                    CreateWordField (UCRS, \_SB.PCI0.SBRG.MUAR._Y01._MIN, UIO1)
                    CreateWordField (UCRS, \_SB.PCI0.SBRG.MUAR._Y01._MAX, UIO2)
                }
                Device (IPIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                    })
                }
                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        DMA (Compatibility, BusMaster, Transfer8, )
                            {4}
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0087,             // Range Minimum
                            0x0087,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0089,             // Range Minimum
                            0x0089,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x008F,             // Range Minimum
                            0x008F,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x00,               // Alignment
                            0x20,               // Length
                            )
                    })
                }
                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                    })
                }
                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }
                Device (UAR1)
                {
                    Name (_UID, One)
                    Name (_HID, EisaId ("PNP0501"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (DSTA (Zero))
                    }
                    Method (_DIS, 0, NotSerialized)
                    {
                        DCNT (Zero, Zero)
                    }
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (DCRS (Zero, Zero))
                    }
                    Method (_SRS, 1, NotSerialized)
                    {
                        DSRS (Arg0, Zero)
                    }
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (CMPR)
                    }
                    Name (CMPR, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IO (Decode16,
                                0x03F8,             // Range Minimum
                                0x03F8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {4}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03F8,             // Range Minimum
                                0x03F8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x02F8,             // Range Minimum
                                0x02F8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03E8,             // Range Minimum
                                0x03E8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x02E8,             // Range Minimum
                                0x02E8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        EndDependentFn ()
                    })
                }
                Device (UAR2)
                {
                    Name (_UID, 0x02)
                    Method (_HID, 0, NotSerialized)
                    {
                        Return (UHID (One))
                    }
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (DSTA (One))
                    }
                    Method (_DIS, 0, NotSerialized)
                    {
                        DCNT (One, Zero)
                    }
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (DCRS (One, One))
                    }
                    Method (_SRS, 1, NotSerialized)
                    {
                        DSRS (Arg0, One)
                    }
                    Method (_PRS, 0, NotSerialized)
                    {
                        Return (CMPR)
                    }
                    Name (CMPR, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IO (Decode16,
                                0x02F8,             // Range Minimum
                                0x02F8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03F8,             // Range Minimum
                                0x03F8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x02F8,             // Range Minimum
                                0x02F8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03E8,             // Range Minimum
                                0x03E8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x02E8,             // Range Minimum
                                0x02E8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03F8,             // Range Minimum
                                0x03F8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x02F8,             // Range Minimum
                                0x02F8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03E8,             // Range Minimum
                                0x03E8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x02E8,             // Range Minimum
                                0x02E8,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        EndDependentFn ()
                    })
                }
                Device (FDC)
                {
                    Name (_HID, EisaId ("PNP0700"))
                    Method (_FDE, 0, NotSerialized)
                    {
                        Name (FDEP, Package (0x05)
                        {
                            Zero, 
                            Zero, 
                            0x02, 
                            0x02, 
                            0x02
                        })
                        If (_STA ())
                        {
                            Store (One, Index (FDEP, Zero))
                        }
                        Return (FDEP)
                    }
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (DSTA (0x03))
                    }
                    Method (_DIS, 0, NotSerialized)
                    {
                        DCNT (0x03, Zero)
                    }
                    Method (_CRS, 0, NotSerialized)
                    {
                        DCRS (0x03, One)
                        Store (IRQM, IRQE)
                        Store (DMAM, DMAE)
                        Store (IO11, IO21)
                        Store (IO12, IO22)
                        Store (0x06, LEN2)
                        Add (IO21, 0x07, IO31)
                        Store (IO31, IO32)
                        Store (One, LEN3)
                        Return (CRS2)
                    }
                    Method (_SRS, 1, NotSerialized)
                    {
                        DSRS (Arg0, 0x03)
                        CreateWordField (Arg0, 0x11, IRQE)
                        CreateByteField (Arg0, 0x14, DMAE)
                        ENFG (CGLD (0x03))
                        If (IRQE)
                        {
                            FindSetRightBit (IRQE, Local0)
                            Subtract (Local0, One, INTR)
                        }
                        Else
                        {
                            Store (Zero, INTR)
                        }
                        If (DMAE)
                        {
                            FindSetRightBit (DMAE, Local0)
                            Subtract (Local0, One, DMCH)
                        }
                        Else
                        {
                            Store (0x04, DMCH)
                        }
                        EXFG ()
                    }
                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IO (Decode16,
                                0x03F0,             // Range Minimum
                                0x03F0,             // Range Maximum
                                0x01,               // Alignment
                                0x06,               // Length
                                )
                            IO (Decode16,
                                0x03F7,             // Range Minimum
                                0x03F7,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IRQNoFlags ()
                                {6}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {2}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03F0,             // Range Minimum
                                0x03F0,             // Range Maximum
                                0x01,               // Alignment
                                0x06,               // Length
                                )
                            IO (Decode16,
                                0x03F7,             // Range Minimum
                                0x03F7,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x0370,             // Range Minimum
                                0x0370,             // Range Maximum
                                0x01,               // Alignment
                                0x06,               // Length
                                )
                            IO (Decode16,
                                0x0377,             // Range Minimum
                                0x0377,             // Range Maximum
                                0x01,               // Alignment
                                0x01,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        EndDependentFn ()
                    })
                }
                Device (LPTE)
                {
                    Method (_HID, 0, NotSerialized)
                    {
                        If (LPTM (0x02))
                        {
                            Return (0x0104D041)
                        }
                        Else
                        {
                            Return (0x0004D041)
                        }
                    }
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (DSTA (0x02))
                    }
                    Method (_DIS, 0, NotSerialized)
                    {
                        DCNT (0x02, Zero)
                    }
                    Method (_CRS, 0, NotSerialized)
                    {
                        DCRS (0x02, One)
                        If (LPTM (0x02))
                        {
                            Store (IRQM, IRQE)
                            Store (DMAM, DMAE)
                            Store (IO11, IO21)
                            Store (IO12, IO22)
                            Store (LEN1, LEN2)
                            Add (IO21, 0x0400, IO31)
                            Store (IO31, IO32)
                            Store (LEN2, LEN3)
                            Return (CRS2)
                        }
                        Else
                        {
                            Return (CRS1)
                        }
                    }
                    Method (_SRS, 1, NotSerialized)
                    {
                        DSRS (Arg0, 0x02)
                    }
                    Method (_PRS, 0, NotSerialized)
                    {
                        If (LPTM (0x02))
                        {
                            Return (EPPR)
                        }
                        Else
                        {
                            Return (LPPR)
                        }
                    }
                    Name (LPPR, ResourceTemplate ()
                    {
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x0378,             // Range Minimum
                                0x0378,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x0278,             // Range Minimum
                                0x0278,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03BC,             // Range Minimum
                                0x03BC,             // Range Maximum
                                0x01,               // Alignment
                                0x04,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {}
                        }
                        EndDependentFn ()
                    })
                    Name (EPPR, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IO (Decode16,
                                0x0378,             // Range Minimum
                                0x0378,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0778,             // Range Minimum
                                0x0778,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {7}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x0378,             // Range Minimum
                                0x0378,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0778,             // Range Minimum
                                0x0778,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x0278,             // Range Minimum
                                0x0278,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IO (Decode16,
                                0x0678,             // Range Minimum
                                0x0678,             // Range Maximum
                                0x01,               // Alignment
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        StartDependentFnNoPri ()
                        {
                            IO (Decode16,
                                0x03BC,             // Range Minimum
                                0x03BC,             // Range Maximum
                                0x01,               // Alignment
                                0x04,               // Length
                                )
                            IO (Decode16,
                                0x07BC,             // Range Minimum
                                0x07BC,             // Range Maximum
                                0x01,               // Alignment
                                0x04,               // Length
                                )
                            IRQNoFlags ()
                                {3,4,5,6,7,10,11,12}
                            DMA (Compatibility, NotBusMaster, Transfer8, )
                                {0,1,2,3}
                        }
                        EndDependentFn ()
                    })
                }
                Device (RMSC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x10)
                    Name (CRS, ResourceTemplate ()
                    {
                        DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                            0x00000000,         // Granularity
                            0x000D0000,         // Range Minimum
                            0x000D3FFF,         // Range Maximum
                            0x00000000,         // Translation Offset
                            0x00004000,         // Length
                            ,, , AddressRangeMemory, TypeStatic)
                        DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                            0x00000000,         // Granularity
                            0x000D4000,         // Range Minimum
                            0x000D7FFF,         // Range Maximum
                            0x00000000,         // Translation Offset
                            0x00004000,         // Length
                            ,, , AddressRangeMemory, TypeStatic)
                        DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                            0x00000000,         // Granularity
                            0x000DE000,         // Range Minimum
                            0x000DFFFF,         // Range Maximum
                            0x00000000,         // Translation Offset
                            0x00002000,         // Length
                            ,, , AddressRangeMemory, TypeStatic)
                        IO (Decode16,
                            0x0010,             // Range Minimum
                            0x0010,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0022,             // Range Minimum
                            0x0022,             // Range Maximum
                            0x00,               // Alignment
                            0x1E,               // Length
                            )
                        IO (Decode16,
                            0x0044,             // Range Minimum
                            0x0044,             // Range Maximum
                            0x00,               // Alignment
                            0x0A,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x00,               // Alignment
                            0x0B,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x00,               // Alignment
                            0x0E,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0084,             // Range Minimum
                            0x0084,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0088,             // Range Minimum
                            0x0088,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x008C,             // Range Minimum
                            0x008C,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0090,             // Range Minimum
                            0x0090,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x00A2,             // Range Minimum
                            0x00A2,             // Range Maximum
                            0x00,               // Alignment
                            0x1E,               // Length
                            )
                        IO (Decode16,
                            0x00E0,             // Range Minimum
                            0x00E0,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0800,             // Range Minimum
                            0x0800,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y02)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y03)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y04)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y05)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y06)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y07)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0A)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y08)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y09)
                        Memory32Fixed (ReadOnly,
                            0xFEE01000,         // Address Base
                            0x000FF000,         // Address Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._MIN, GP00)
                        CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._MAX, GP01)
                        CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._LEN, GP0L)
                        CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y03._MIN, GP10)
                        CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y03._MAX, GP11)
                        CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y03._LEN, GP1L)
                        Store (PMBS, GP00)
                        Store (PMBS, GP01)
                        If (LGreaterEqual (PMLN, 0x0100))
                        {
                            ShiftRight (PMLN, One, GP0L)
                            Add (GP00, GP0L, GP10)
                            Add (GP01, GP0L, GP11)
                            Subtract (PMLN, GP0L, GP1L)
                        }
                        Else
                        {
                            Store (PMLN, GP0L)
                        }
                        If (SCBS)
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y04._MIN, SC00)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y04._MAX, SC01)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y04._LEN, SC0L)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y05._MIN, SC10)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y05._MAX, SC11)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y05._LEN, SC1L)
                            Store (SCBS, SC00)
                            Store (SCBS, SC01)
                            If (LGreaterEqual (SCLN, 0x0100))
                            {
                                ShiftRight (SCLN, One, SC0L)
                                Add (SC00, SC0L, SC10)
                                Add (SC01, SC0L, SC11)
                                Subtract (SCLN, SC0L, SC1L)
                            }
                            Else
                            {
                                Store (SCLN, SC0L)
                            }
                        }
                        If (ACBS)
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y06._MIN, AC00)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y06._MAX, AC01)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y06._LEN, AC0L)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y07._MIN, AC10)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y07._MAX, AC11)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y07._LEN, AC1L)
                            Store (ACBS, AC00)
                            Store (ACBS, AC01)
                            If (LGreaterEqual (ACLN, 0x0100))
                            {
                                ShiftRight (ACLN, One, AC0L)
                                Add (AC00, AC0L, AC10)
                                Add (AC01, AC0L, AC11)
                                Subtract (ACLN, AC0L, AC1L)
                            }
                            Else
                            {
                                Store (ACLN, AC0L)
                            }
                        }
                        If (SPAS)
                        {
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y08._BAS, BB01)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y08._LEN, BL01)
                            Store (SPAM, BB01)
                            Store (SPAL, BL01)
                        }
                        If (SNAS)
                        {
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y09._BAS, AB01)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y09._LEN, AL01)
                            Store (SNAM, AB01)
                            Store (SNAL, AL01)
                        }
                        CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y0A._BAS, MB01)
                        CreateDWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y0A._LEN, ML01)
                        Store (CPB1, MB01)
                        Store (CPB2, ML01)
                        Return (CRS)
                    }
                }
                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (_CID, EisaId ("PNP0C01"))
                    Name (_STA, 0x0F)
                    Name (_UID, Zero)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0}
                        IRQNoFlags ()
                            {8}
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            )
                    })
                }
                OperationRegion (LPDC, PCI_Config, 0xA0, 0x06)
                Field (LPDC, ByteAcc, NoLock, Preserve)
                {
                    S3F8,   1, 
                    S2F8,   1, 
                        ,   3, 
                    S2E8,   1, 
                        ,   1, 
                    S3E8,   1, 
                        ,   4, 
                    M300,   1, 
                        ,   2, 
                    M330,   1, 
                        ,   4, 
                    FDC0,   1, 
                    Offset (0x03), 
                    P378,   1, 
                    P278,   1, 
                    P3BC,   1, 
                    Offset (0x04), 
                    G200,   8, 
                    G208,   8
                }
                Method (RRIO, 4, NotSerialized)
                {
                    If (LOr (LEqual (Arg0, Zero), LEqual (Arg0, One)))
                    {
                        If (LEqual (Arg2, 0x03F8))
                        {
                            Store (Arg1, S3F8)
                        }
                        If (LEqual (Arg2, 0x02F8))
                        {
                            Store (Arg1, S2F8)
                        }
                        If (LEqual (Arg2, 0x03E8))
                        {
                            Store (Arg1, S3E8)
                        }
                        If (LEqual (Arg2, 0x02E8))
                        {
                            Store (Arg1, S2E8)
                        }
                    }
                    If (LEqual (Arg0, 0x02))
                    {
                        If (LEqual (Arg2, 0x0378))
                        {
                            Store (Arg1, P378)
                        }
                        If (LEqual (Arg2, 0x0278))
                        {
                            Store (Arg1, P278)
                        }
                        If (LEqual (Arg2, 0x03BC))
                        {
                            Store (Arg1, P3BC)
                        }
                    }
                    If (LEqual (Arg0, 0x03))
                    {
                        Store (Arg1, FDC0)
                    }
                    If (LEqual (Arg0, 0x05))
                    {
                        If (LEqual (Arg2, 0x0330))
                        {
                            Store (Arg1, M330)
                        }
                        If (LEqual (Arg2, 0x0300))
                        {
                            Store (Arg1, M300)
                        }
                    }
                    If (LEqual (Arg0, 0x08))
                    {
                        Store (Zero, Local0)
                        If (Arg1)
                        {
                            Store (0xFF, Local0)
                        }
                        If (LEqual (Arg2, 0x0200))
                        {
                            Store (Local0, G200)
                        }
                        If (LEqual (Arg2, 0x0208))
                        {
                            Store (Local0, G208)
                        }
                    }
                }
                Method (RDMA, 3, NotSerialized)
                {
                }
                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                    })
                }
                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (
                            Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                        )
                    })
                }
                Device (^PCIE)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x11)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xE0000000,         // Address Base
                            0x10000000,         // Address Length
                            _Y0D)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, \_SB.PCI0.PCIE._Y0D._BAS, BAS1)
                        CreateDWordField (CRS, \_SB.PCI0.PCIE._Y0D._LEN, LEN1)
                        Store (PCIB, BAS1)
                        Store (PCIL, LEN1)
                        Return (CRS)
                    }
                }
                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, Zero)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0E)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0F)
                    })
                    Name (CRS1, ResourceTemplate ()
                    {
                        FixedIO (
                            0x0060,             // Address
                            0x01,               // Length
                            )
                        FixedIO (
                            0x0064,             // Address
                            0x01,               // Length
                            )
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y10)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y11)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (APIC)
                        {
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.LDRC._Y0E._LEN, ML01)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.LDRC._Y0E._BAS, MB01)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.LDRC._Y0F._LEN, ML02)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.LDRC._Y0F._BAS, MB02)
                            Store (0xFEC00000, MB01)
                            Store (0x1000, ML01)
                            Store (0xFEE00000, MB02)
                            Store (0x1000, ML02)
                            CreateDWordField (CRS1, \_SB.PCI0.SBRG.LDRC._Y10._LEN, ML03)
                            CreateDWordField (CRS1, \_SB.PCI0.SBRG.LDRC._Y10._BAS, MB03)
                            CreateDWordField (CRS1, \_SB.PCI0.SBRG.LDRC._Y11._LEN, ML04)
                            CreateDWordField (CRS1, \_SB.PCI0.SBRG.LDRC._Y11._BAS, MB04)
                            Store (0xFEC00000, MB03)
                            Store (0x1000, ML03)
                            Store (0xFEE00000, MB04)
                            Store (0x1000, ML04)
                        }
                        ShiftLeft (0x05, 0x0A, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (CRS)
                        }
                        Else
                        {
                            Return (CRS1)
                        }
                    }
                }
                Device (^^RMEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, One)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x000A0000,         // Address Length
                            )
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y12)
                        Memory32Fixed (ReadOnly,
                            0x000E0000,         // Address Base
                            0x00020000,         // Address Length
                            _Y13)
                        Memory32Fixed (ReadWrite,
                            0x00100000,         // Address Base
                            0x00000000,         // Address Length
                            _Y14)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y15)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, \_SB.RMEM._Y12._BAS, BAS1)
                        CreateDWordField (CRS, \_SB.RMEM._Y12._LEN, LEN1)
                        CreateDWordField (CRS, \_SB.RMEM._Y13._BAS, BAS2)
                        CreateDWordField (CRS, \_SB.RMEM._Y13._LEN, LEN2)
                        CreateDWordField (CRS, \_SB.RMEM._Y14._LEN, LEN3)
                        CreateDWordField (CRS, \_SB.RMEM._Y15._BAS, BAS4)
                        CreateDWordField (CRS, \_SB.RMEM._Y15._LEN, LEN4)
                        If (OSFL ()) {}
                        Else
                        {
                            If (MG1B)
                            {
                                If (LGreater (MG1B, 0x000C0000))
                                {
                                    Store (0x000C0000, BAS1)
                                    Subtract (MG1B, BAS1, LEN1)
                                }
                            }
                            Else
                            {
                                Store (0x000C0000, BAS1)
                                Store (0x00020000, LEN1)
                            }
                            If (Add (MG1B, MG1L, Local0))
                            {
                                Store (Local0, BAS2)
                                Subtract (0x00100000, BAS2, LEN2)
                            }
                        }
                        Subtract (MG2B, 0x00100000, LEN3)
                        Store (MH1B, BAS4)
                        Subtract (Zero, BAS4, LEN4)
                        Return (CRS)
                    }
                }
                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CID, EisaId ("PNP030B"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ShiftLeft (One, 0x0A, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (0x0F)
                        }
                        Return (Zero)
                    }
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                }
                Method (PS2K._PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x10, 0x04))
                }
                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F03"))
                    Name (_CID, EisaId ("PNP0F13"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ShiftLeft (One, 0x0C, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (0x0F)
                        }
                        Return (Zero)
                    }
                    Name (M2R0, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {12}
                    })
                    Name (M2R1, ResourceTemplate ()
                    {
                        FixedIO (
                            0x0060,             // Address
                            0x01,               // Length
                            )
                        FixedIO (
                            0x0064,             // Address
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {12}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        ShiftLeft (One, 0x0A, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (M2R0)
                        }
                        Else
                        {
                            Return (M2R1)
                        }
                    }
                }
                Method (PS2M._PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x10, 0x04))
                }
                Device (SIOR)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Method (_UID, 0, NotSerialized)
                    {
                        Return (SPIO)
                    }
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y16)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y17)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y18)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (LAnd (LNotEqual (SPIO, 0x03F0), LGreater (SPIO, 0xF0)))
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.SIOR._Y16._MIN, GP10)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.SIOR._Y16._MAX, GP11)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.SIOR._Y16._LEN, GPL1)
                            Store (SPIO, GP10)
                            Store (SPIO, GP11)
                            Store (0x02, GPL1)
                        }
                        If (IOSB)
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.SIOR._Y17._MIN, GP20)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.SIOR._Y17._MAX, GP21)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.SIOR._Y17._LEN, GPL2)
                            Store (IOSB, GP20)
                            Store (IOSB, GP21)
                            Store (IOSL, GPL2)
                        }
                        If (IOHB)
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.SIOR._Y18._MIN, GP30)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.SIOR._Y18._MAX, GP31)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.SIOR._Y18._LEN, GPL3)
                            Store (IOHB, GP30)
                            Store (IOHB, GP31)
                            Store (IOHL, GPL3)
                        }
                        Return (CRS)
                    }
                }
                Name (DCAT, Package (0x16)
                {
                    0x02, 
                    0x03, 
                    One, 
                    Zero, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0x07, 
                    0x09, 
                    0xFF, 
                    0xFF, 
                    0xFF, 
                    0xFF
                })
                Method (ENFG, 1, NotSerialized)
                {
                    Store (0x87, INDX)
                    Store (0x87, INDX)
                    Store (Arg0, LDN)
                }
                Method (EXFG, 0, NotSerialized)
                {
                    Store (0xAA, INDX)
                }
                Method (LPTM, 1, NotSerialized)
                {
                    ENFG (CGLD (Arg0))
                    And (OPT0, 0x02, Local0)
                    EXFG ()
                    Return (Local0)
                }
                Method (UHID, 1, NotSerialized)
                {
                    If (LEqual (Arg0, One))
                    {
                        ENFG (CGLD (Arg0))
                        And (OPT1, 0x38, Local0)
                        EXFG ()
                        If (Local0)
                        {
                            Return (0x1005D041)
                        }
                    }
                    Return (0x0105D041)
                }
                Method (SIOK, 1, NotSerialized)
                {
                    ENFG (0x0A)
                    And (0xFF, OPT3, OPT3)
                    And (Arg0, One, Local0)
                    Or (OPT2, Local0, OPT2)
                    Store (And (Arg0, One), ACTR)
                    EXFG ()
                }
                Name (KBFG, One)
                Name (MSFG, One)
                Name (U1FG, One)
                Name (U2FG, One)
                OperationRegion (KBRW, SystemIO, 0x60, 0x05)
                Field (KBRW, ByteAcc, NoLock, Preserve)
                {
                    KP60,   8, 
                    Offset (0x04), 
                    KP64,   8
                }
                OperationRegion (KB64, SystemIO, 0x64, One)
                Field (KB64, ByteAcc, NoLock, Preserve)
                {
                        ,   1, 
                    KRDY,   1, 
                    Offset (0x01)
                }
                Method (PS2K._PSW, 1, NotSerialized)
                {
                    If (LNot (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02))))
                    {
                        If (Arg0)
                        {
                            Store (One, KBFG)
                        }
                        Else
                        {
                            Store (Zero, KBFG)
                        }
                    }
                }
                Method (PS2M._PSW, 1, NotSerialized)
                {
                    If (LNot (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02))))
                    {
                        If (Arg0)
                        {
                            Store (One, MSFG)
                        }
                        Else
                        {
                            Store (Zero, MSFG)
                        }
                    }
                }
                Method (SIOS, 1, NotSerialized)
                {
                    Store ("SIOS", Debug)
                    And (CRE0, 0x1F, CRE0)
                    If (LEqual (Arg0, One))
                    {
                        SIOK (Ones)
                        ENFG (0x0A)
                        If (KBFG)
                        {
                            Or (OPT6, 0x10, OPT6)
                        }
                        If (MSFG)
                        {
                            Or (OPT6, 0x20, OPT6)
                        }
                        EXFG ()
                    }
                    If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
                    {
                        If (WKTP)
                        {
                            SIOK (Ones)
                            ENFG (0x0A)
                            If (KBFG)
                            {
                                Or (OPT6, 0x10, OPT6)
                            }
                            If (MSFG)
                            {
                                Or (OPT6, 0x20, OPT6)
                            }
                            EXFG ()
                        }
                        Else
                        {
                            ENFG (0x0A)
                            If (KBFG)
                            {
                                Or (CRE0, 0x41, CRE0)
                            }
                            If (MSFG)
                            {
                                Or (CRE0, 0x22, CRE0)
                                Or (CRE6, 0x80, CRE6)
                            }
                            EXFG ()
                        }
                    }
                }
                Method (SIOW, 1, NotSerialized)
                {
                    If (LEqual (Arg0, One))
                    {
                        ENFG (0x08)
                        Store (0x40, OPT5)
                        Store (Zero, OPT5)
                        EXFG ()
                    }
                    Store ("SIOW", Debug)
                    SIOK (Zero)
                    ENFG (0x0A)
                    And (OPT6, 0xCF, OPT6)
                    And (OPT2, 0xFE, OPT2)
                    And (CRE0, 0x1D, CRE0)
                    And (CRE6, 0x7F, CRE6)
                    EXFG ()
                }
                Method (SIOH, 0, NotSerialized)
                {
                    Store ("SIOH", Debug)
                    ENFG (0x0A)
                    If (And (OPT3, 0x10))
                    {
                        Notify (PS2K, 0x02)
                    }
                    If (And (OPT3, 0x20))
                    {
                        Notify (PS2M, 0x02)
                    }
                    SIOK (Zero)
                }
                OperationRegion (IOID, SystemIO, SPIO, 0x02)
                Field (IOID, ByteAcc, NoLock, Preserve)
                {
                    INDX,   8, 
                    DATA,   8
                }
                IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x07), 
                    LDN,    8, 
                    Offset (0x22), 
                    FDCP,   1, 
                        ,   2, 
                    LPTP,   1, 
                    URAP,   1, 
                    URBP,   1, 
                    Offset (0x30), 
                    ACTR,   8, 
                    Offset (0x60), 
                    IOAH,   8, 
                    IOAL,   8, 
                    IOH2,   8, 
                    IOL2,   8, 
                    Offset (0x70), 
                    INTR,   8, 
                    Offset (0x74), 
                    DMCH,   8, 
                    Offset (0xE0), 
                    CRE0,   8, 
                    CRE1,   8, 
                    CRE2,   8, 
                    CRE3,   8, 
                    CRE4,   8, 
                    CRE5,   8, 
                    CRE6,   8, 
                    Offset (0xF0), 
                    OPT0,   8, 
                    OPT1,   8, 
                    OPT2,   8, 
                    OPT3,   8, 
                    OPT4,   8, 
                    OPT5,   8, 
                    OPT6,   8
                }
                Method (CGLD, 1, NotSerialized)
                {
                    Return (DerefOf (Index (DCAT, Arg0)))
                }
                Method (DSTA, 1, NotSerialized)
                {
                    ENFG (CGLD (Arg0))
                    Store (ACTR, Local0)
                    EXFG ()
                    If (LEqual (Local0, 0xFF))
                    {
                        Return (Zero)
                    }
                    And (Local0, One, Local0)
                    Or (IOST, ShiftLeft (Local0, Arg0), IOST)
                    If (Local0)
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        If (And (ShiftLeft (One, Arg0), IOST))
                        {
                            Return (0x0D)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }
                Method (DCNT, 2, NotSerialized)
                {
                    ENFG (CGLD (Arg0))
                    ShiftLeft (IOAH, 0x08, Local1)
                    Or (IOAL, Local1, Local1)
                    If (LAnd (LLess (DMCH, 0x04), LNotEqual (And (DMCH, 0x03, 
                        Local1), Zero)))
                    {
                        RDMA (Arg0, Arg1, Increment (Local1))
                    }
                    Store (Arg1, ACTR)
                    RRIO (Arg0, Arg1, Local1, 0x08)
                    EXFG ()
                }
                Name (CRS1, ResourceTemplate ()
                {
                    IO (Decode16,
                        0x0000,             // Range Minimum
                        0x0000,             // Range Maximum
                        0x01,               // Alignment
                        0x00,               // Length
                        _Y1B)
                    IRQNoFlags (_Y19)
                        {}
                    DMA (Compatibility, NotBusMaster, Transfer8, _Y1A)
                        {}
                })
                CreateWordField (CRS1, \_SB.PCI0.SBRG._Y19._INT, IRQM)
                CreateByteField (CRS1, \_SB.PCI0.SBRG._Y1A._DMA, DMAM)
                CreateWordField (CRS1, \_SB.PCI0.SBRG._Y1B._MIN, IO11)
                CreateWordField (CRS1, \_SB.PCI0.SBRG._Y1B._MAX, IO12)
                CreateByteField (CRS1, \_SB.PCI0.SBRG._Y1B._LEN, LEN1)
                Name (CRS2, ResourceTemplate ()
                {
                    IO (Decode16,
                        0x0000,             // Range Minimum
                        0x0000,             // Range Maximum
                        0x01,               // Alignment
                        0x00,               // Length
                        _Y1E)
                    IO (Decode16,
                        0x0000,             // Range Minimum
                        0x0000,             // Range Maximum
                        0x01,               // Alignment
                        0x00,               // Length
                        _Y1F)
                    IRQNoFlags (_Y1C)
                        {6}
                    DMA (Compatibility, NotBusMaster, Transfer8, _Y1D)
                        {2}
                })
                CreateWordField (CRS2, \_SB.PCI0.SBRG._Y1C._INT, IRQE)
                CreateByteField (CRS2, \_SB.PCI0.SBRG._Y1D._DMA, DMAE)
                CreateWordField (CRS2, \_SB.PCI0.SBRG._Y1E._MIN, IO21)
                CreateWordField (CRS2, \_SB.PCI0.SBRG._Y1E._MAX, IO22)
                CreateByteField (CRS2, \_SB.PCI0.SBRG._Y1E._LEN, LEN2)
                CreateWordField (CRS2, \_SB.PCI0.SBRG._Y1F._MIN, IO31)
                CreateWordField (CRS2, \_SB.PCI0.SBRG._Y1F._MAX, IO32)
                CreateByteField (CRS2, \_SB.PCI0.SBRG._Y1F._LEN, LEN3)
                Method (DCRS, 2, NotSerialized)
                {
                    ENFG (CGLD (Arg0))
                    ShiftLeft (IOAH, 0x08, IO11)
                    Or (IOAL, IO11, IO11)
                    Store (IO11, IO12)
                    Subtract (FindSetRightBit (IO11), One, Local0)
                    ShiftLeft (One, Local0, LEN1)
                    If (INTR)
                    {
                        ShiftLeft (One, INTR, IRQM)
                    }
                    Else
                    {
                        Store (Zero, IRQM)
                    }
                    If (LOr (LGreater (DMCH, 0x03), LEqual (Arg1, Zero)))
                    {
                        Store (Zero, DMAM)
                    }
                    Else
                    {
                        And (DMCH, 0x03, Local1)
                        ShiftLeft (One, Local1, DMAM)
                    }
                    EXFG ()
                    Return (CRS1)
                }
                Method (DSRS, 2, NotSerialized)
                {
                    CreateWordField (Arg0, 0x09, IRQM)
                    CreateByteField (Arg0, 0x0C, DMAM)
                    CreateWordField (Arg0, 0x02, IO11)
                    ENFG (CGLD (Arg1))
                    ShiftLeft (IOAH, 0x08, Local1)
                    Or (IOAL, Local1, Local1)
                    RRIO (Arg1, Zero, Local1, 0x08)
                    RRIO (Arg1, One, IO11, 0x08)
                    And (IO11, 0xFF, IOAL)
                    ShiftRight (IO11, 0x08, IOAH)
                    If (IRQM)
                    {
                        FindSetRightBit (IRQM, Local0)
                        Subtract (Local0, One, INTR)
                    }
                    Else
                    {
                        Store (Zero, INTR)
                    }
                    If (DMAM)
                    {
                        FindSetRightBit (DMAM, Local0)
                        Subtract (Local0, One, DMCH)
                    }
                    Else
                    {
                        Store (0x04, DMCH)
                    }
                    EXFG ()
                    DCNT (Arg1, One)
                }
            }
            Device (IMAP)
            {
                Name (_ADR, 0x00010004)
                OperationRegion (PIMC, PCI_Config, 0x60, 0x54)
                Field (PIMC, ByteAcc, NoLock, Preserve)
                {
                    PIID,   8, 
                    Offset (0x04), 
                    PILN,   8, 
                    Offset (0x08), 
                    PIU0,   8, 
                    PIU2,   8, 
                    UBR1,   8, 
                    UBR2,   8, 
                    Offset (0x0D), 
                    Offset (0x0E), 
                    PIRM,   8, 
                    PMUD,   8, 
                    PAZA,   8, 
                    GPUR,   8, 
                    PR0E,   8, 
                    Offset (0x14), 
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    Offset (0x1C), 
                    P0EA,   8, 
                    P0EB,   8, 
                    P0EC,   8, 
                    P0ED,   8, 
                    P1EA,   8, 
                    P1EB,   8, 
                    P1EC,   8, 
                    P1ED,   8, 
                    P2EA,   8, 
                    P2EB,   8, 
                    P2EC,   8, 
                    P2ED,   8, 
                    P3EA,   8, 
                    P3EB,   8, 
                    P3EC,   8, 
                    P3ED,   8, 
                    P4EA,   8, 
                    P4EB,   8, 
                    P4EC,   8, 
                    P4ED,   8, 
                    P5EA,   8, 
                    P5EB,   8, 
                    P5EC,   8, 
                    P5ED,   8, 
                    P6EA,   8, 
                    P6EB,   8, 
                    P6EC,   8, 
                    P6ED,   8, 
                    P7EA,   8, 
                    P7EB,   8, 
                    P7EC,   8, 
                    P7ED,   8, 
                    Offset (0x4C), 
                    XVE0,   8, 
                    XVE1,   8, 
                    XVE2,   8, 
                    XVE3,   8, 
                    XVE4,   8, 
                    XVE5,   8, 
                    XVE6,   8, 
                    XVE7,   8
                }
            }
            Device (OHC0)
            {
                Name (_ADR, 0x00020000)
                Name (_S1D, One)
                Name (UPS1, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x03)
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (UPS1)
                }
            }
            Device (OHC1)
            {
                Name (_ADR, 0x00020001)
                Name (_S1D, One)
                Name (UPS1, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)
                {
                    Return (0x03)
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (UPS1)
                }
            }
            Device (EHC0)
            {
                Name (_ADR, 0x00040000)
                Name (_S1D, One)
                Name (UPS1, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)
                {
                        Return (0x03)
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (UPS1)
                }
            }
            Device (EHC1)
            {
                Name (_ADR, 0x00040001)
                Name (_S1D, One)
                Name (UPS1, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_S3D, 0, NotSerialized)
                {
                        Return (0x03)
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (UPS1)
                }
            }
            Device (NMAC)
            {
                Name (_ADR, 0x000A0000)
                Name (_PRW, Package (0x02)
                {
                    0x0B, 
                    0x05
                })
                Scope (\_GPE)
                {
                    Method (_L0B, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.NMAC, 0x02)
                        Notify (\_SB.PWRB, 0x02)
                    }
                }
            }
            Device (SATA)
            {
                Name (_ADR, 0x00090000)
                OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
                Field (SACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    SECT,   16, 
                    PSIT,   4, 
                    SSIT,   4, 
                            Offset (0x08), 
                    SYNC,   4, 
                            Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                            Offset (0x0B), 
                    SDT2,   2, 
                        ,   2, 
                    SDT3,   2, 
                            Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4, 
                            Offset (0x50), 
                    MAPV,   2
                }
                Method (_DSM, 4, NotSerialized)
                {
                    Store (Package (0x02)
                    {
                        "device-id",
                        Buffer (0x04)
                        {
                            0x81, 0x26, 0x00, 0x00
                        }
                    }, Local0)
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }
            }
            Device (P0P1)
            {
                Name (_ADR, 0x00080000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (Zero, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR01)
                    }
                    Return (PR01)
                }
            }
            Device (HDAC)
            {
                Name (_ADR, 0x00070000)
                Name (SCID, Zero)
                Name (SACW, Zero)
                Method (_PS0, 0, NotSerialized)
                {
                    If (SCID)
                    {
                        Store (Zero, PMDS)
                        Store (Zero, PMEN)
                        Store (SCID, CDID)
                        Store (SACW, AOCW)
                    }
                }
                Method (_PS3, 0, NotSerialized)
                {
                    Store (AOCW, SACW)
                    Store (CDID, SCID)
                    Store (One, PMST)
                    Store (0x03, PMDS)
                    Store (One, PMEN)
                }
                OperationRegion (PMCF, PCI_Config, 0x48, 0x02)
                Field (PMCF, ByteAcc, NoLock, Preserve)
                {
                    PMDS,   2, 
                    Offset (0x01), 
                    PMEN,   1, 
                        ,   6, 
                    PMST,   1
                }
                OperationRegion (DCF2, PCI_Config, 0xE0, 0x08)
                Field (DCF2, ByteAcc, NoLock, Preserve)
                {
                    AOCW,   32, 
                    Offset (0x06), 
                    CDID,   8
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x15, 0x04))
                }
            }
            Device (IXVE)
            {
                Name (_ADR, 0x000B0000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR02)
                    }
                    Return (PR02)
                }
                /*Device (IGPU)
                {
                    Name (_ADR, Zero)
                }*/
            }
            Device (MXR0)
            {
                Name (_ADR, 0x00100000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x11, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR10)
                    }
                    Return (PR10)
                }
                Device (GFX0)
                {
                    Name (_ADR, Zero)
                    Method (_DSM, 4, NotSerialized)
                    {
                        Store (Package (0x18)
                            {
                                "@0,compatible", 
                                Buffer (0x0B)
                                {
                                    "NVDA,NVMac"
                                }, 
                                "@0,device_type", 
                                Buffer (0x08)
                                {
                                    "display"
                                }, 
                                "@0,name", 
                                Buffer (0x0F)
                                {
                                    "NVDA,Display-A"
                                }, 
                                "@1,compatible", 
                                Buffer (0x0B)
                                {
                                    "NVDA,NVMac"
                                }, 
                                "@1,device_type", 
                                Buffer (0x08)
                                {
                                    "display"
                                }, 
                                "@1,name", 
                                Buffer (0x0F)
                                {
                                    "NVDA,Display-B"
                                }, 
                                "NVCAP", 
                                Buffer (0x14)
                                {
                                    /* 0000 */   0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x00,
                                    /* 0008 */   0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A,
                                    /* 0010 */   0x00, 0x00, 0x00, 0x00
                                }, 
                                "NVPM", 
                                Buffer (0x1C)
                                {
                                    /* 0000 */   0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                    /* 0008 */   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                    /* 0010 */   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                    /* 0018 */   0x00, 0x00, 0x00, 0x00
                                }, 
                                "VRAM,totalsize", 
                                Buffer (0x04)
                                {
                                     0x00, 0x00, 0x00, 0x40
                                }, 
                                "device_type", 
                                Buffer (0x0C)
                                {
                                    "NVDA,Parent"
                                }, 
                                "model", 
                                Buffer (0x14)
                                {
                                    "EVGA GeForce GT 440"
                                }, 
                                "rom-revision", 
                                Buffer (0x0F)
                                {
                                    "70.08.29.00.42"
                                }
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                        Return (Local0)
                    }
                }
            }
            Device (BR11)
            {
                Name (_ADR, 0x00110000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x11, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR11)
                    }
                    Return (PR11)
                }
            }
            Device (BR12)
            {
                Name (_ADR, 0x00120000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x11, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR12)
                    }
                    Return (PR12)
                }
            }
            Device (BR13)
            {
                Name (_ADR, 0x00130000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x11, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR13)
                    }
                    Return (PR13)
                }
            }
            Device (BR14)
            {
                Name (_ADR, 0x00140000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x11, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR14)
                    }
                    Return (PR14)
                }
            }
            Device (BR15)
            {
                Name (_ADR, 0x00150000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x11, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR15)
                    }
                    Return (PR15)
                }
            }
            Device (BR16)
            {
                Name (_ADR, 0x00160000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x11, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR16)
                    }
                    Return (PR16)
                }
            }
            Device (BR17)
            {
                Name (_ADR, 0x00170000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x11, 0x04))
                }
                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR17)
                    }
                    Return (PR17)
                }
            }
            Device (SBUS)
            {
                Name (_ADR, 0x00010001)
                Device (BUS0)
                {
                    Name (_CID, "smbus")
                    Name (_ADR, Zero)
                    Device (DVL0)
                    {
                        Name (_ADR, 0x57)
                        Name (_CID, "diagsvault")
                    }
                }
                Method (_DSM, 4, NotSerialized)
                {
                    Store (Package (0x02)
                        {
                            "device-id", 
                            Buffer (0x04)
                            {
                                0x30, 0x3A, 0x00, 0x00
                            }
                        }, Local0)
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }
            }
        }
        Scope (\_GPE)
        {
            Method (_L10, 0, NotSerialized)
            {
                \_SB.PCI0.SBRG.SIOH ()
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L09, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.SBUS, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L0D, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.OHC0, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L05, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.OHC1, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L18, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.EHC0, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L17, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.EHC1, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L00, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.P0P1, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L15, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.HDAC, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L11, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.MXR0, 0x02)
                Notify (\_SB.PCI0.BR11, 0x02)
                Notify (\_SB.PCI0.BR12, 0x02)
                Notify (\_SB.PCI0.BR13, 0x02)
                Notify (\_SB.PCI0.BR14, 0x02)
                Notify (\_SB.PCI0.BR15, 0x02)
                Notify (\_SB.PCI0.BR16, 0x02)
                Notify (\_SB.PCI0.BR17, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
        }
        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_UID, 0xAA)
            Name (_STA, 0x0B)
            Method (_PRW, 0, NotSerialized)
            {
                Return (GPRW (0x10, 0x04))
            }
        }
    }
    Scope (_SB)
    {
        Name (BUFA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {15}
        })
        CreateWordField (BUFA, One, ICRS)
        Method (LSTA, 1, NotSerialized)
        {
            If (Arg0)
            {
                Return (0x0B)
            }
            Else
            {
                Return (0x09)
            }
        }
        Method (LPRS, 2, NotSerialized)
        {
            If (PICM)
            {
                Return (Arg1)
            }
            Else
            {
                Return (Arg0)
            }
        }
        Method (LCRS, 1, NotSerialized)
        {
            If (PICM)
            {
                Name (BUFB, ResourceTemplate ()
                {
                    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, _Y20)
                    {
                        0x00000011,
                    }
                })
                CreateDWordField (BUFB, \_SB.LCRS._Y20._INT, AIRQ)
                Store (Arg0, AIRQ)
                If (LEqual (Arg0, One))
                {
                    Store (0x17, AIRQ)
                }
                If (LEqual (Arg0, 0x02))
                {
                    Store (0x16, AIRQ)
                }
                If (LEqual (Arg0, 0x0D))
                {
                    Store (0x15, AIRQ)
                }
                If (LEqual (Arg0, 0x08))
                {
                    Store (0x14, AIRQ)
                }
                If (LEqual (Arg0, 0x0C))
                {
                    Store (0x13, AIRQ)
                }
                If (LEqual (Arg0, 0x06))
                {
                    Store (0x12, AIRQ)
                }
                If (LEqual (Arg0, 0x04))
                {
                    Store (0x11, AIRQ)
                }
                If (LEqual (Arg0, 0x03))
                {
                    Store (0x10, AIRQ)
                }
                If (LEqual (Arg0, 0x0F))
                {
                    Store (0x0F, AIRQ)
                }
                If (LEqual (Arg0, 0x0E))
                {
                    Store (0x0E, AIRQ)
                }
                If (LEqual (Arg0, 0x0B))
                {
                    Store (0x0B, AIRQ)
                }
                If (LEqual (Arg0, 0x0A))
                {
                    Store (0x0A, AIRQ)
                }
                If (LEqual (Arg0, 0x09))
                {
                    Store (0x09, AIRQ)
                }
                If (LEqual (Arg0, 0x07))
                {
                    Store (0x07, AIRQ)
                }
                If (LEqual (Arg0, 0x05))
                {
                    Store (0x05, AIRQ)
                }
                Return (BUFB)
            }
            Else
            {
                ShiftLeft (One, Arg0, ICRS)
                Return (BUFA)
            }
        }
        Method (LCRO, 1, NotSerialized)
        {
            If (PICM)
            {
                Name (BUFB, ResourceTemplate ()
                {
                    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, _Y21)
                    {
                        0x00000014,
                    }
                })
                CreateDWordField (BUFB, \_SB.LCRO._Y21._INT, AIRQ)
                Store (Arg0, AIRQ)
                If (LEqual (Arg0, One))
                {
                    Store (0x17, AIRQ)
                }
                If (LEqual (Arg0, 0x02))
                {
                    Store (0x16, AIRQ)
                }
                If (LEqual (Arg0, 0x0D))
                {
                    Store (0x15, AIRQ)
                }
                If (LEqual (Arg0, 0x08))
                {
                    Store (0x14, AIRQ)
                }
                If (LEqual (Arg0, 0x0C))
                {
                    Store (0x13, AIRQ)
                }
                If (LEqual (Arg0, 0x06))
                {
                    Store (0x12, AIRQ)
                }
                If (LEqual (Arg0, 0x04))
                {
                    Store (0x11, AIRQ)
                }
                If (LEqual (Arg0, 0x03))
                {
                    Store (0x10, AIRQ)
                }
                If (LEqual (Arg0, 0x0F))
                {
                    Store (0x0F, AIRQ)
                }
                If (LEqual (Arg0, 0x0E))
                {
                    Store (0x0E, AIRQ)
                }
                If (LEqual (Arg0, 0x0B))
                {
                    Store (0x0B, AIRQ)
                }
                If (LEqual (Arg0, 0x0A))
                {
                    Store (0x0A, AIRQ)
                }
                If (LEqual (Arg0, 0x09))
                {
                    Store (0x09, AIRQ)
                }
                If (LEqual (Arg0, 0x07))
                {
                    Store (0x07, AIRQ)
                }
                If (LEqual (Arg0, 0x05))
                {
                    Store (0x05, AIRQ)
                }
                Return (BUFB)
            }
            Else
            {
                ShiftLeft (One, Arg0, ICRS)
                Return (BUFA)
            }
        }
        Method (LSRS, 1, NotSerialized)
        {
            If (PICM)
            {
                CreateByteField (Arg0, 0x05, SAIR)
                Store (SAIR, Local0)
                If (LEqual (Local0, 0x17))
                {
                    Store (One, Local0)
                }
                If (LEqual (Local0, 0x16))
                {
                    Store (0x02, Local0)
                }
                If (LEqual (Local0, 0x15))
                {
                    Store (0x0D, Local0)
                }
                If (LEqual (Local0, 0x14))
                {
                    Store (0x08, Local0)
                }
                If (LEqual (Local0, 0x13))
                {
                    Store (0x0C, Local0)
                }
                If (LEqual (Local0, 0x12))
                {
                    Store (0x06, Local0)
                }
                If (LEqual (Local0, 0x11))
                {
                    Store (0x04, Local0)
                }
                If (LEqual (Local0, 0x10))
                {
                    Store (0x03, Local0)
                }
                If (LEqual (Local0, 0x0F))
                {
                    Store (0x0F, Local0)
                }
                If (LEqual (Local0, 0x0E))
                {
                    Store (0x0E, Local0)
                }
                If (LEqual (Local0, 0x0B))
                {
                    Store (0x0B, Local0)
                }
                If (LEqual (Local0, 0x0A))
                {
                    Store (0x0A, Local0)
                }
                If (LEqual (Local0, 0x09))
                {
                    Store (0x09, Local0)
                }
                If (LEqual (Local0, 0x07))
                {
                    Store (0x07, Local0)
                }
                If (LEqual (Local0, 0x05))
                {
                    Store (0x05, Local0)
                }
                Return (Local0)
            }
            Else
            {
                CreateWordField (Arg0, One, ISRS)
                FindSetRightBit (ISRS, Local0)
                Return (Decrement (Local0))
            }
        }
        Method (LSRO, 1, NotSerialized)
        {
            If (PICM)
            {
                CreateByteField (Arg0, 0x05, SAIR)
                Store (SAIR, Local0)
                If (LEqual (Local0, 0x17))
                {
                    Store (One, Local0)
                }
                If (LEqual (Local0, 0x16))
                {
                    Store (0x02, Local0)
                }
                If (LEqual (Local0, 0x15))
                {
                    Store (0x0D, Local0)
                }
                If (LEqual (Local0, 0x14))
                {
                    Store (0x08, Local0)
                }
                If (LEqual (Local0, 0x13))
                {
                    Store (0x0C, Local0)
                }
                If (LEqual (Local0, 0x12))
                {
                    Store (0x06, Local0)
                }
                If (LEqual (Local0, 0x11))
                {
                    Store (0x04, Local0)
                }
                If (LEqual (Local0, 0x10))
                {
                    Store (0x03, Local0)
                }
                If (LEqual (Local0, 0x0F))
                {
                    Store (0x0F, Local0)
                }
                If (LEqual (Local0, 0x0E))
                {
                    Store (0x0E, Local0)
                }
                If (LEqual (Local0, 0x0B))
                {
                    Store (0x0B, Local0)
                }
                If (LEqual (Local0, 0x0A))
                {
                    Store (0x0A, Local0)
                }
                If (LEqual (Local0, 0x09))
                {
                    Store (0x09, Local0)
                }
                If (LEqual (Local0, 0x07))
                {
                    Store (0x07, Local0)
                }
                If (LEqual (Local0, 0x05))
                {
                    Store (0x05, Local0)
                }
                Return (Local0)
            }
            Else
            {
                CreateWordField (Arg0, One, ISRS)
                FindSetRightBit (ISRS, Local0)
                Return (Decrement (Local0))
            }
        }
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, One)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PIRA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PIRA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.PIRA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.PIRA)
            }
        }
        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PIRB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PIRB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.PIRB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.PIRB)
            }
        }
        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x03)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PIRC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PIRC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.PIRC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.PIRC)
            }
        }
        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x04)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PIRD))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PIRD)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.PIRD))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.PIRD)
            }
        }
        Device (LN0A)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x05)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P0EA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P0EA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P0EA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P0EA)
            }
        }
        Device (LN0B)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x06)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P0EB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P0EB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P0EB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P0EB)
            }
        }
        Device (LN0C)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x07)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P0EC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P0EC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P0EC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P0EC)
            }
        }
        Device (LN0D)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x08)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P0ED))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P0ED)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P0ED))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P0ED)
            }
        }
        Device (LN1A)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x09)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P1EA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P1EA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P1EA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P1EA)
            }
        }
        Device (LN1B)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x0A)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P1EB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P1EB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P1EB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P1EB)
            }
        }
        Device (LN1C)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x0B)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P1EC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P1EC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P1EC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P1EC)
            }
        }
        Device (LN1D)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x0C)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P1ED))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P1ED)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P1ED))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P1ED)
            }
        }
        Device (LN2A)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x0D)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P2EA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P2EA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P2EA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P2EA)
            }
        }
        Device (LN2B)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x0E)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P2EB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P2EB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P2EB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P2EB)
            }
        }
        Device (LN2C)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x0F)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P2EC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P2EC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P2EC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P2EC)
            }
        }
        Device (LN2D)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x10)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P2ED))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P2ED)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P2ED))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P2ED)
            }
        }
        Device (LN3A)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x11)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P3EA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P3EA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P3EA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P3EA)
            }
        }
        Device (LN3B)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x12)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P3EB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P3EB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P3EB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P3EB)
            }
        }
        Device (LN3C)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x13)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P3EC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P3EC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P3EC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P3EC)
            }
        }
        Device (LN3D)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x14)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P3ED))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P3ED)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P3ED))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P3ED)
            }
        }
        Device (LN4A)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x15)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P4EA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P4EA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P4EA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P4EA)
            }
        }
        Device (LN4B)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x16)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P4EB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P4EB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P4EB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P4EB)
            }
        }
        Device (LN4C)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x17)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P4EC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P4EC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P4EC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P4EC)
            }
        }
        Device (LN4D)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x18)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P4ED))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P4ED)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P4ED))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P4ED)
            }
        }
        Device (LN5A)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x19)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P5EA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P5EA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P5EA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P5EA)
            }
        }
        Device (LN5B)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x1A)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P5EB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P5EB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P5EB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P5EB)
            }
        }
        Device (LN5C)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x1B)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P5EC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P5EC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P5EC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P5EC)
            }
        }
        Device (LN5D)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x1B)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P5ED))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P5ED)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P5ED))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P5ED)
            }
        }
        Device (LN6A)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x1C)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P6EA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P6EA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P6EA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P6EA)
            }
        }
        Device (LN6B)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x1D)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P6EB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P6EB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P6EB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P6EB)
            }
        }
        Device (LN6C)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x1E)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P6EC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P6EC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P6EC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P6EC)
            }
        }
        Device (LN6D)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x1F)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P6ED))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P6ED)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P6ED))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P6ED)
            }
        }
        Device (LN7A)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x20)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P7EA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSA, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P7EA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P7EA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P7EA)
            }
        }
        Device (LN7B)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x21)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P7EB))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSB, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P7EB)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P7EB))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P7EB)
            }
        }
        Device (LN7C)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x22)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P7EC))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSC, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P7EC)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P7EC))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P7EC)
            }
        }
        Device (LN7D)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x23)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.P7ED))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (PRSD, RSIR))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.P7ED)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (^^PCI0.IMAP.P7ED))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRS (Arg0), ^^PCI0.IMAP.P7ED)
            }
        }
        Device (LUB0)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x24)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PIU0))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSB0, RSU1))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PIU0)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.PIU0))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.PIU0)
            }
        }
        Device (LUB2)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x25)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PIU2))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSB2, RSI1))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PIU2)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.PIU2))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.PIU2)
            }
        }
        Device (LMAC)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x26)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PILN))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSAC, RSMA))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PILN)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.PILN))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.PILN)
            }
        }
        Device (LAZA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x27)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PAZA))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSZA, RSII))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PAZA)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.PAZA))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.PAZA)
            }
        }
        Device (SGRU)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x28)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.GPUR))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSRU, RSIG))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.GPUR)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.GPUR))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.GPUR)
            }
        }
        Device (LSMB)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x29)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PIRM))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSMB, RSII))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PIRM)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.PIRM))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.PIRM)
            }
        }
        Device (LPMU)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x2A)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PMUD))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSMU, RSII))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PMUD)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.PMUD))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.PMUD)
            }
        }
        Device (LSA0)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x2B)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PIID))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSA0, RSSA))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PIID)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.PIID))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.PIID)
            }
        }
        Device (LATA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x2C)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.PR0E))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RSTA, RSII))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.PR0E)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.PR0E))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.PR0E)
            }
        }
        Device (UB11)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x2D)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.UBR1))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RS11, RSU2))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.UBR1)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.UBR1))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.UBR1)
            }
        }
        Device (UB12)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x2E)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (^^PCI0.IMAP.UBR2))
            }
            Method (_PRS, 0, NotSerialized)
            {
                Return (LPRS (RS12, RSI2))
            }
            Method (_DIS, 0, NotSerialized)
            {
                Store (Zero, ^^PCI0.IMAP.UBR2)
            }
            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRO (^^PCI0.IMAP.UBR2))
            }
            Method (_SRS, 1, NotSerialized)
            {
                Store (LSRO (Arg0), ^^PCI0.IMAP.UBR2)
            }
        }
    }
    Scope (_SB)
    {
        Name (XCPD, Zero)
        Name (XNPT, One)
        Name (XCAP, 0x02)
        Name (XDCP, 0x04)
        Name (XDCT, 0x08)
        Name (XDST, 0x0A)
        Name (XLCP, 0x0C)
        Name (XLCT, 0x10)
        Name (XLST, 0x12)
        Name (XSCP, 0x14)
        Name (XSCT, 0x18)
        Name (XSST, 0x1A)
        Name (XRCT, 0x1C)
        Mutex (MUTE, 0x00)
        Method (RBPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, One)
            Field (PCFG, ByteAcc, NoLock, Preserve)
            {
                XCFG,   8
            }
            Release (MUTE)
            Return (XCFG)
        }
        Method (RWPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFE, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x02)
            Field (PCFG, WordAcc, NoLock, Preserve)
            {
                XCFG,   16
            }
            Release (MUTE)
            Return (XCFG)
        }
        Method (RDPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFC, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }
            Release (MUTE)
            Return (XCFG)
        }
        Method (WBPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, One)
            Field (PCFG, ByteAcc, NoLock, Preserve)
            {
                XCFG,   8
            }
            Store (Arg1, XCFG)
            Release (MUTE)
        }
        Method (WWPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFE, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x02)
            Field (PCFG, WordAcc, NoLock, Preserve)
            {
                XCFG,   16
            }
            Store (Arg1, XCFG)
            Release (MUTE)
        }
        Method (WDPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFC, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }
            Store (Arg1, XCFG)
            Release (MUTE)
        }
        Method (RWDP, 3, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFC, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }
            And (XCFG, Arg2, Local1)
            Or (Local1, Arg1, XCFG)
            Release (MUTE)
        }
        Method (RPME, 1, NotSerialized)
        {
            Add (Arg0, 0x84, Local0)
            Store (RDPE (Local0), Local1)
            If (LEqual (Local1, Ones))
            {
                Return (Zero)
            }
            Else
            {
                If (LAnd (Local1, 0x00010000))
                {
                    WDPE (Local0, And (Local1, 0x00010000))
                    Return (One)
                }
                Return (Zero)
            }
        }
    }
    Scope (_SB.PCI0)
    {
        Method (_OSC, 4, NotSerialized)
        {
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            CreateDWordField (Arg3, Zero, CDW1)
            CreateDWordField (Arg3, 0x04, CDW2)
            CreateDWordField (Arg3, 0x08, CDW3)
            If (LEqual (Arg0, Buffer (0x10)
                    {
                        /* 0000 */   0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40,
                        /* 0008 */   0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66
                    }))
            {
                Store (CDW2, SUPP)
                Store (CDW3, CTRL)
                If (LNotEqual (And (SUPP, 0x16), 0x16))
                {
                    And (CTRL, 0x1E, CTRL)
                }
                If (LNot (PEHP))
                {
                    And (CTRL, 0x1E, CTRL)
                }
                If (LNot (SHPC))
                {
                    And (CTRL, 0x1D, CTRL)
                }
                If (LNot (PEPM))
                {
                    And (CTRL, 0x1B, CTRL)
                }
                If (LNot (PEER))
                {
                    And (CTRL, 0x15, CTRL)
                }
                If (LNot (PECS))
                {
                    And (CTRL, 0x0F, CTRL)
                }
                If (Not (And (CDW1, One)))
                {
                    If (And (CTRL, One)) {}
                    /*If (And (CTRL, 0x04))
                    {
                        ^SMB0.GPMD (One)
                        Store (One, ^SMB0.XPME)
                    }*/
                    If (And (CTRL, 0x10)) {}
                }
                If (LNotEqual (Arg1, One))
                {
                    Or (CDW1, 0x08, CDW1)
                }
                If (LNotEqual (CDW3, CTRL))
                {
                    Or (CDW1, 0x10, CDW1)
                }
                Store (CTRL, CDW3)
                Return (Arg3)
            }
            Else
            {
                Or (CDW1, 0x04, CDW1)
                Return (Arg3)
            }
        }
    }
    Method (NPTS, 1, NotSerialized)
    {
    }
    Method (NWAK, 1, NotSerialized)
    {
    }
    Name (FZTF, Buffer (0x07)
    {
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF5
    })
    OperationRegion (IOID, SystemIO, 0x0A15, 0x02)
    Field (IOID, ByteAcc, NoLock, Preserve)
    {
        INDX,   8, 
        DATA,   8
    }
    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
    {
        Offset (0x4E), 
        CR4E,   8, 
        Offset (0x50), 
        TM50,   8, 
        Offset (0x53), 
        OV53,   8, 
        OV54,   8, 
        OV55,   8
    }
    Scope (_TZ)
    {
        Method (KELT, 1, NotSerialized)
        {
            And (Arg0, 0xFF, Local0)
            If (LGreater (Local0, 0x7F))
            {
                Store (0x06, Local0)
            }
            Multiply (Local0, 0x0A, Local0)
            Add (Local0, 0x0AAC, Local0)
            Return (Local0)
        }
        Method (KELV, 1, NotSerialized)
        {
            And (Arg0, 0xFF, Local0)
            Multiply (Local0, 0x0A, Local0)
            Add (Local0, 0x0AAC, Local0)
            Return (Local0)
        }
        ThermalZone (THRM)
        {
            Method (_TMP, 0, NotSerialized)
            {
                Store (One, CR4E)
                Store (TM50, Local0)
                If (LEqual (And (TM50, 0x80), 0x80))
                {
                    Return (Zero)
                }
                Return (KELT (Local0))
            }
            Method (_CRT, 0, NotSerialized)
            {
                Store (One, CR4E)
                Store (OV55, Local0)
                Return (KELV (Local0))
            }
        }
    }
    Name (HWMF, Zero)
    Scope (_GPE)
    {
        Method (_L02, 0, NotSerialized)
        {
            Store (0x33, HWMF)
            Store (0xDD, DBG8)
            Notify (\_TZ.THRM, 0x80)
        }
    }
    Scope (_SB)
    {
        Scope (PCI0)
        {
            Name (CRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, )
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    ,, , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, _Y22, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y23, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y24, AddressRangeMemory, TypeStatic)
            })
            CreateDWordField (CRS, \_SB.PCI0._Y22._MIN, MIN5)
            CreateDWordField (CRS, \_SB.PCI0._Y22._MAX, MAX5)
            CreateDWordField (CRS, \_SB.PCI0._Y22._LEN, LEN5)
            CreateDWordField (CRS, \_SB.PCI0._Y23._MIN, MIN6)
            CreateDWordField (CRS, \_SB.PCI0._Y23._MAX, MAX6)
            CreateDWordField (CRS, \_SB.PCI0._Y23._LEN, LEN6)
            CreateDWordField (CRS, \_SB.PCI0._Y24._MIN, MIN7)
            CreateDWordField (CRS, \_SB.PCI0._Y24._MAX, MAX7)
            CreateDWordField (CRS, \_SB.PCI0._Y24._LEN, LEN7)
            Method (_CRS, 0, NotSerialized)
            {
                Store (MG1L, Local0)
                If (Local0)
                {
                    Store (MG1B, MIN5)
                    Store (MG1L, LEN5)
                    Add (MIN5, Decrement (Local0), MAX5)
                }
                Store (MG2B, MIN6)
                Store (MG2L, LEN6)
                Store (MG2L, Local0)
                Add (MIN6, Decrement (Local0), MAX6)
                Store (MG3B, MIN7)
                Store (MG3L, LEN7)
                Store (MG3L, Local0)
                Add (MIN7, Decrement (Local0), MAX7)
                Return (CRS)
            }
        }
    }
    Name (WOTB, Zero)
    Name (WSSB, Zero)
    Name (WAXB, Zero)
    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, DBG8)
        PTS (Arg0)
        Store (Zero, Index (WAKP, Zero))
        Store (Zero, Index (WAKP, One))
        If (LAnd (LEqual (Arg0, 0x04), LEqual (OSFL (), 0x02)))
        {
            Sleep (0x0BB8)
        }
        Store (ASSB, WSSB)
        Store (AOTB, WOTB)
        Store (AAXB, WAXB)
        Store (Arg0, ASSB)
        Store (OSFL (), AOTB)
        Store (OSYS (), OSTP)
        Store (Zero, AAXB)
    }
    Method (_WAK, 1, NotSerialized)
    {
        ShiftLeft (Arg0, 0x04, DBG8)
        WAK (Arg0)
        If (ASSB)
        {
            Store (WSSB, ASSB)
            Store (WOTB, AOTB)
            Store (WAXB, AAXB)
        }
        If (DerefOf (Index (WAKP, Zero)))
        {
            Store (Zero, Index (WAKP, One))
        }
        Else
        {
            Store (Arg0, Index (WAKP, One))
        }
        Return (WAKP)
    }
    Name (_S0, Package (0x04)
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    If (SS1)
    {
        Name (_S1, Package (0x04)
        {
            One, 
            Zero, 
            Zero, 
            Zero
        })
    }
    If (SS3)
    {
        Name (_S3, Package (0x04)
        {
            0x05, 
            Zero, 
            Zero, 
            Zero
        })
    }
    If (SS4)
    {
        Name (_S4, Package (0x04)
        {
            0x06, 
            Zero, 
            Zero, 
            Zero
        })
    }
    Name (_S5, Package (0x04)
    {
        0x07, 
        Zero, 
        Zero, 
        Zero
    })
    Method (PTS, 1, NotSerialized)
    {
        If (Arg0)
        {
            \_SB.PCI0.SBRG.SIOS (Arg0)
            NPTS (Arg0)
            \_SB.PCI0.SBRG.SPTS (Arg0)
        }
    }
    Method (WAK, 1, NotSerialized)
    {
        \_SB.PCI0.SBRG.SIOW (Arg0)
        NWAK (Arg0)
        \_SB.PCI0.SBRG.SWAK (Arg0)
    }
    Method (DTGP, 5, NotSerialized)
    {
        If (LEqual (Arg0, Buffer (0x10)
                {
                    /* 0000 */    0xC6, 0xB7, 0xB5, 0xA0, 0x18, 0x13, 0x1C, 0x44, 
                    /* 0008 */    0xB0, 0xC9, 0xFE, 0x69, 0x5E, 0xAF, 0x94, 0x9B
                }))
        {
            If (LEqual (Arg1, One))
            {
                If (LEqual (Arg2, Zero))
                {
                    Store (Buffer (One)
                        {
                            0x03
                        }, Arg4)
                    Return (One)
                }
                If (LEqual (Arg2, One))
                {
                    Return (One)
                }
            }
        }
        Store (Buffer (One)
            {
                0x00
            }, Arg4)
        Return (Zero)
    }
}
