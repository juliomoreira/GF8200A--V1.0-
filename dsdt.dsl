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
        Store (0x10, Local0)
        If (CondRefOf (_OSI, Local1))
        {
            If (_OSI ("Windows 2000"))
            {
                Store (0x12, Local0)
            }
            If (_OSI ("Windows 2001"))
            {
                Store (0x13, Local0)
            }
            If (_OSI ("Windows 2001 SP1"))
            {
                Store (0x13, Local0)
            }
            If (_OSI ("Windows 2001 SP2"))
            {
                Store (0x13, Local0)
            }
            If (_OSI ("Windows 2001.1"))
            {
                Store (0x14, Local0)
            }
            If (_OSI ("Windows 2001.1 SP1"))
            {
                Store (0x14, Local0)
            }
            If (_OSI ("Windows 2006"))
            {
                Store (0x15, Local0)
            }
        }
        Else
        {
            If (MCTH (_OS, "Microsoft Windows NT"))
            {
                Store (0x12, Local0)
            }
            Else
            {
                If (MCTH (_OS, "Microsoft WindowsME: Millennium Edition"))
                {
                    Store (0x11, Local0)
                }
            }
        }
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
                    Store (Arg0, ^^IDE0.PTS0)
                    Store (^^IDE0.ID20, ^^IDE0.SID0)
                    Store (^^IDE0.IDTS, ^^IDE0.SID1)
                    Store (^^IDE0.IDTP, ^^IDE0.SID2)
                    Store (^^IDE0.ID22, ^^IDE0.SID3)
                    Store (^^IDE0.UMSS, ^^IDE0.SID4)
                    Store (^^IDE0.UMSP, ^^IDE0.SID5)
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
                Device (PIC)
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
                        IRQNoFlags ()
                            {2}
                    })
                }
                Device (DMAD)
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
                Device (COPR)
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
                    Name (_UID, Zero)
                    Name (CRS0, ResourceTemplate ()
                    {
                    })
                    Name (CRS1, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0B)
                        IRQNoFlags (_Y0C)
                            {0}
                        IRQNoFlags ()
                            {8}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (OSFL (), Zero))
                        {
                            If (LEqual (NVID, 0x10DE))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS1, \_SB.PCI0.SBRG.HPET._Y0B._BAS, HPX1)
                        CreateDWordField (CRS1, \_SB.PCI0.SBRG.HPET._Y0B._LEN, HPX2)
                        CreateWordField (CRS1, \_SB.PCI0.SBRG.HPET._Y0C._INT, TIRQ)
                        If (LEqual (NVID, 0x10DE))
                        {
                            Store (Zero, Local0)
                            If (P2IR)
                            {
                                Store (0x02, Local0)
                            }
                            ShiftLeft (One, Local0, TIRQ)
                            Store (SHPB, HPX1)
                            Store (SHPL, HPX2)
                            Return (CRS1)
                        }
                        Else
                        {
                            Return (CRS0)
                        }
                    }
                    OperationRegion (CF29, PCI_Config, 0x74, One)
                    Field (CF29, ByteAcc, NoLock, Preserve)
                    {
                            ,   1, 
                            ,   1, 
                        P2IR,   1
                    }
                    OperationRegion (HPTE, SystemMemory, SHPB, 0x04)
                    Field (HPTE, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x02), 
                        NVID,   16
                    }
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
                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (CRS0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                    Name (CRS1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (LEqual (^^HPET.NVID, 0x10DE))
                        {
                            Return (CRS1)
                        }
                        Return (CRS0)
                    }
                }
                Device (RTC0)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (CRS0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                    Name (CRS1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (LEqual (^^HPET.NVID, 0x10DE))
                        {
                            Return (CRS1)
                        }
                        Return (CRS0)
                    }
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
                Device (OMSC)
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
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y0E._LEN, ML01)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y0E._BAS, MB01)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y0F._LEN, ML02)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y0F._BAS, MB02)
                            Store (0xFEC00000, MB01)
                            Store (0x1000, ML01)
                            Store (0xFEE00000, MB02)
                            Store (0x1000, ML02)
                            CreateDWordField (CRS1, \_SB.PCI0.SBRG.OMSC._Y10._LEN, ML03)
                            CreateDWordField (CRS1, \_SB.PCI0.SBRG.OMSC._Y10._BAS, MB03)
                            CreateDWordField (CRS1, \_SB.PCI0.SBRG.OMSC._Y11._LEN, ML04)
                            CreateDWordField (CRS1, \_SB.PCI0.SBRG.OMSC._Y11._BAS, MB04)
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
            Device (SMB0)
            {
                Name (_ADR, 0x00010001)
                OperationRegion (SMAD, PCI_Config, 0x20, 0x08)
                Field (SMAD, DWordAcc, NoLock, Preserve)
                {
                    SB1,    32, 
                    SB2,    32
                }
                OperationRegion (SMCF, PCI_Config, 0x48, 0x10)
                Field (SMCF, DWordAcc, NoLock, Preserve)
                {
                    SMPM,   4, 
                    SMT1,   28, 
                    SMT2,   32
                }
                OperationRegion (SME4, PCI_Config, 0xE4, 0x04)
                Field (SME4, AnyAcc, NoLock, Preserve)
                {
                        ,   17, 
                    XPME,   1
                }
                Method (GPMD, 1, NotSerialized)
                {
                    Store (Arg0, XPME)
                }
                Method (SMBB, 1, NotSerialized)
                {
                    If (LEqual (Arg0, Zero))
                    {
                        And (SB1, 0xFFFE, Local0)
                    }
                    Else
                    {
                        And (SB2, 0xFFFE, Local0)
                    }
                    Return (Local0)
                }
                Scope (^^PCI0)
                {
                    OperationRegion (SM00, SystemIO, SMB0.SMBB (One), 0x40)
                    Field (SM00, ByteAcc, NoLock, Preserve)
                    {
                        CTLR,   8, 
                        HSTS,   8, 
                        ADDR,   8, 
                        CMDR,   8, 
                        DAT0,   8, 
                        DAT1,   8, 
                        Offset (0x25), 
                        ALAD,   8, 
                        ALDL,   8, 
                        ALDH,   8
                    }
                    Field (SM00, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x04), 
                        SB32,   256
                    }
                    Method (SWFS, 0, NotSerialized)
                    {
                        Store (0x0A, Local0)
                        While (Local0)
                        {
                            If (And (HSTS, 0x80))
                            {
                                Break
                            }
                            Sleep (One)
                            Decrement (Local0)
                        }
                    }
                    Method (SRBY, 2, NotSerialized)
                    {
                        Store (Arg0, ADDR)
                        Store (Arg1, CMDR)
                        Store (0x04, CTLR)
                        SWFS ()
                    }
                    Method (WBYT, 3, NotSerialized)
                    {
                        Store (Arg0, ADDR)
                        Store (Arg1, CMDR)
                        Store (Arg2, DAT0)
                        Store (0x06, CTLR)
                        SWFS ()
                    }
                    Method (CLAR, 0, NotSerialized)
                    {
                        And (HSTS, 0x40, Local0)
                        If (LEqual (Local0, 0x40))
                        {
                            Store (0x05, CTLR)
                            Stall (0x64)
                            Store (DAT0, Local1)
                            Store (Zero, HSTS)
                            Stall (0x64)
                        }
                        SWFS ()
                    }
                    Method (SMWW, 4, NotSerialized)
                    {
                        Store (Arg0, ADDR)
                        Store (Arg1, CMDR)
                        Store (Arg2, DAT0)
                        Store (Arg3, DAT1)
                        Store (0x08, CTLR)
                        SWFS ()
                    }
                    Method (RBYT, 2, NotSerialized)
                    {
                        Store (Arg0, ADDR)
                        Store (Arg1, CMDR)
                        Store (0x07, CTLR)
                        SWFS ()
                        Return (DAT0)
                    }
                    Method (SMRW, 2, NotSerialized)
                    {
                        Store (Arg0, ADDR)
                        Store (Arg1, CMDR)
                        Store (0x09, CTLR)
                        SWFS ()
                        Store (DAT0, Local0)
                        ShiftLeft (DAT1, 0x08, Local1)
                        Or (Local0, Local1, Local2)
                        Return (Local2)
                    }
                    Method (SMRB, 2, NotSerialized)
                    {
                        Store (Arg0, ADDR)
                        Store (Arg1, CMDR)
                        Store (0x0B, CTLR)
                        SWFS ()
                        Return (SB32)
                    }
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x09, 0x04))
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
            Device (USB0)
            {
                Name (_ADR, 0x00020000)
                Name (_S1D, One)
                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x0D, 0x04))
                }
            }
            Device (USB2)
            {
                Name (_ADR, 0x00020001)
                Name (_S1D, One)
                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x05, 0x03))
                }
            }
            Device (US15)
            {
                Name (_ADR, 0x00040000)
                Name (_S1D, One)
                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x18, 0x04))
                }
            }
            Device (US12)
            {
                Name (_ADR, 0x00040001)
                Name (_S1D, One)
                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x17, 0x03))
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
            Device (IDE0)
            {
                Name (_ADR, 0x00060000)
                Name (PTS0, Zero)
                Name (SID0, Zero)
                Name (SID1, Zero)
                Name (SID2, Zero)
                Name (SID3, Zero)
                Name (SID4, Zero)
                Name (SID5, Zero)
                OperationRegion (IRQM, SystemIO, 0x21, One)
                Field (IRQM, ByteAcc, NoLock, Preserve)
                {
                    IR0M,   1
                }
                Name (REGF, One)
                Method (_REG, 2, NotSerialized)
                {
                    If (LEqual (Arg0, 0x02))
                    {
                        Store (Arg1, REGF)
                    }
                }
                OperationRegion (A090, PCI_Config, 0x50, 0x18)
                Field (A090, DWordAcc, NoLock, Preserve)
                {
                    ID20,   16, 
                    Offset (0x08), 
                    IDTS,   16, 
                    IDTP,   16, 
                    ID22,   32, 
                    UMSS,   16, 
                    UMSP,   16
                }
                Name (TIM0, Package (0x07)
                {
                    Package (0x05)
                    {
                        0x3C, 
                        0x78, 
                        0xB4, 
                        0xF0, 
                        0x0384
                    }, 
                    Package (0x05)
                    {
                        0x11, 
                        0x20, 
                        0x22, 
                        0x47, 
                        0xA8
                    }, 
                    Package (0x07)
                    {
                        0x78, 
                        0x49, 
                        0x3C, 
                        0x2D, 
                        0x1E, 
                        0x14, 
                        0x0F
                    }, 
                    Package (0x05)
                    {
                        0x05, 
                        0x04, 
                        0x03, 
                        0x02, 
                        Zero
                    }, 
                    Package (0x04)
                    {
                        0x02, 
                        One, 
                        Zero, 
                        Zero
                    }, 
                    Package (0x08)
                    {
                        0x02, 
                        One, 
                        Zero, 
                        Zero, 
                        0x03, 
                        0x04, 
                        0x05, 
                        0x06
                    }, 
                    Package (0x07)
                    {
                        0x02, 
                        One, 
                        Zero, 
                        0x04, 
                        0x05, 
                        0x06, 
                        0x07
                    }
                })
                Name (TMD0, Buffer (0x14) {})
                CreateDWordField (TMD0, Zero, PIO0)
                CreateDWordField (TMD0, 0x04, DMA0)
                CreateDWordField (TMD0, 0x08, PIO1)
                CreateDWordField (TMD0, 0x0C, DMA1)
                CreateDWordField (TMD0, 0x10, CHNF)
                OperationRegion (CFG2, PCI_Config, 0x58, 0x0C)
                Field (CFG2, DWordAcc, NoLock, Preserve)
                {
                    SSPT,   8, 
                    SMPT,   8, 
                    PSPT,   8, 
                    PMPT,   8, 
                    SSAS,   2, 
                    SMAS,   2, 
                    PSAS,   2, 
                    PMAS,   2, 
                    Offset (0x06), 
                    SDDR,   4, 
                    SDDA,   4, 
                    PDDR,   4, 
                    PDDA,   4, 
                    SSUT,   3, 
                        ,   3, 
                    SSUE,   2, 
                    SMUT,   3, 
                        ,   3, 
                    SMUE,   2, 
                    PSUT,   3, 
                        ,   3, 
                    PSUE,   2, 
                    PMUT,   3, 
                        ,   3, 
                    PMUE,   2
                }
                Name (GMPT, Zero)
                Name (GMUE, Zero)
                Name (GMUT, Zero)
                Name (GSPT, Zero)
                Name (GSUE, Zero)
                Name (GSUT, Zero)
                Device (CHN0)
                {
                    Name (_ADR, Zero)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store ("GTM_CHN0", Debug)
                        Return (GTM (PMPT, PMUE, PMUT, PSPT, PSUE, PSUT))
                    }
                    Method (_STM, 3, NotSerialized)
                    {
                        Store ("STM_CHN0", Debug)
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        Store (PMPT, GMPT)
                        Store (PMUE, GMUE)
                        Store (PMUT, GMUT)
                        Store (PSPT, GSPT)
                        Store (PSUE, GSUE)
                        Store (PSUT, GSUT)
                        STM ()
                        Store (GMPT, PMPT)
                        Store (GMUE, PMUE)
                        Store (GMUT, PMUT)
                        Store (GSPT, PSPT)
                        Store (GSUE, PSUE)
                        Store (GSUT, PSUT)
                        Store (GTF (Zero, Arg1), ATA0)
                        Store (GTF (One, Arg2), ATA1)
                    }
                    Device (DRV0)
                    {
                        Name (_ADR, Zero)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("_GTF_CHN0_DRV0", Debug)
                            Return (Concatenate (RATA (ATA0), FZTF))
                        }
                    }
                    Device (DRV1)
                    {
                        Name (_ADR, One)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("_GTF_CHN0_DRV1", Debug)
                            Return (Concatenate (RATA (ATA1), FZTF))
                        }
                    }
                }
                Device (CHN1)
                {
                    Name (_ADR, One)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Store ("GTM_CHN1", Debug)
                        Return (GTM (SMPT, SMUE, SMUT, SSPT, SSUE, SSUT))
                    }
                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        Store (SMPT, GMPT)
                        Store (SMUE, GMUE)
                        Store (SMUT, GMUT)
                        Store (SSPT, GSPT)
                        Store (SSUE, GSUE)
                        Store (SSUT, GSUT)
                        STM ()
                        Store (GMPT, SMPT)
                        Store (GMUE, SMUE)
                        Store (GMUT, SMUT)
                        Store (GSPT, SSPT)
                        Store (GSUE, SSUE)
                        Store (GSUT, SSUT)
                        Store (GTF (Zero, Arg1), ATA2)
                        Store (GTF (One, Arg2), ATA3)
                    }
                    Device (DRV0)
                    {
                        Name (_ADR, Zero)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("_GTF_CHN1_DRV0", Debug)
                            Return (Concatenate (RATA (ATA2), FZTF))
                        }
                    }
                    Device (DRV1)
                    {
                        Name (_ADR, One)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store ("_GTF_CHN1_DRV1", Debug)
                            Return (Concatenate (RATA (ATA3), FZTF))
                        }
                    }
                }
                Method (DRMP, 0, NotSerialized)
                {
                    ShiftRight (CPB0, 0x04, Local1)
                    And (Local1, 0x0F, Local0)
                    Return (Local0)
                }
                Method (GTM, 6, Serialized)
                {
                    Store (Ones, PIO0)
                    Store (Ones, PIO1)
                    Store (Ones, DMA0)
                    Store (Ones, DMA1)
                    Store (0x10, CHNF)
                    If (REGF) {}
                    Else
                    {
                        Return (TMD0)
                    }
                    If (LEqual (PTS0, One))
                    {
                        If (OSFL ())
                        {
                            Store (One, IR0M)
                        }
                    }
                    Store (Match (DerefOf (Index (TIM0, One)), MEQ, Arg0, MTR, 
                        Zero, Zero), Local6)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, Zero)), Local6)), 
                        Local7)
                    Store (Local7, DMA0)
                    Store (Local7, PIO0)
                    Store (Match (DerefOf (Index (TIM0, One)), MEQ, Arg3, MTR, 
                        Zero, Zero), Local6)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, Zero)), Local6)), 
                        Local7)
                    Store (Local7, DMA1)
                    Store (Local7, PIO1)
                    If (Arg1)
                    {
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x05)), Arg2)), 
                            Local5)
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x02)), Local5)), 
                            DMA0)
                        Or (CHNF, One, CHNF)
                    }
                    If (Arg4)
                    {
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x05)), Arg5)), 
                            Local5)
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x02)), Local5)), 
                            DMA1)
                        Or (CHNF, 0x04, CHNF)
                    }
                    Store (TMD0, Debug)
                    Return (TMD0)
                }
                Method (STM, 0, Serialized)
                {
                    If (REGF) {}
                    Else
                    {
                        Return (Zero)
                    }
                    If (PTS0)
                    {
                        Store (SID0, ID20)
                        Store (SID1, IDTS)
                        Store (SID2, IDTP)
                        Store (SID3, ID22)
                        Store (SID4, UMSS)
                        Store (SID5, UMSP)
                    }
                    Else
                    {
                        Store (ID20, SID0)
                        Store (IDTS, SID1)
                        Store (IDTP, SID2)
                        Store (ID22, SID3)
                        Store (UMSS, SID4)
                        Store (UMSP, SID5)
                    }
                    Store (Zero, PTS0)
                    Store (Zero, GMUE)
                    Store (Zero, GMUT)
                    Store (Zero, GSUE)
                    Store (Zero, GSUT)
                    If (And (CHNF, One))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x02)), MLE, DMA0, MTR, 
                            Zero, Zero), Local0)
                        If (LGreater (Local0, 0x06))
                        {
                            Store (0x06, Local0)
                        }
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x06)), Local0)), 
                            GMUT)
                        Or (GMUE, 0x03, GMUE)
                    }
                    Else
                    {
                        If (Or (LEqual (PIO0, Ones), LEqual (PIO0, Zero)))
                        {
                            If (And (LLess (DMA0, Ones), LGreater (DMA0, Zero)))
                            {
                                Store (DMA0, PIO0)
                            }
                        }
                    }
                    If (And (CHNF, 0x04))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x02)), MLE, DMA1, MTR, 
                            Zero, Zero), Local0)
                        If (LGreater (Local0, 0x06))
                        {
                            Store (0x06, Local0)
                        }
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x06)), Local0)), 
                            GSUT)
                        Or (GSUE, 0x03, GSUE)
                    }
                    Else
                    {
                        If (Or (LEqual (PIO1, Ones), LEqual (PIO1, Zero)))
                        {
                            If (And (LLess (DMA1, Ones), LGreater (DMA1, Zero)))
                            {
                                Store (DMA1, PIO1)
                            }
                        }
                    }
                    And (Match (DerefOf (Index (TIM0, Zero)), MGE, PIO0, MTR, 
                        Zero, Zero), 0x07, Local0)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, One)), Local0)), 
                        Local1)
                    Store (Local1, GMPT)
                    And (Match (DerefOf (Index (TIM0, Zero)), MGE, PIO1, MTR, 
                        Zero, Zero), 0x07, Local0)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, One)), Local0)), 
                        Local1)
                    Store (Local1, GSPT)
                    Return (Zero)
                }
                Name (AT01, Buffer (0x07)
                {
                     0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF
                })
                Name (AT02, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90
                })
                Name (AT03, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC6
                })
                Name (AT04, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x91
                })
                Name (ATA0, Buffer (0x1D) {})
                Name (ATA1, Buffer (0x1D) {})
                Name (ATA2, Buffer (0x1D) {})
                Name (ATA3, Buffer (0x1D) {})
                Name (ATAB, Buffer (0x1D) {})
                CreateByteField (ATAB, Zero, CMDC)
                Method (GTFB, 3, Serialized)
                {
                    Multiply (CMDC, 0x38, Local0)
                    Add (Local0, 0x08, Local1)
                    CreateField (ATAB, Local1, 0x38, CMDX)
                    Multiply (CMDC, 0x07, Local0)
                    CreateByteField (ATAB, Add (Local0, 0x02), A001)
                    CreateByteField (ATAB, Add (Local0, 0x06), A005)
                    Store (Arg0, CMDX)
                    Store (Arg1, A001)
                    Store (Arg2, A005)
                    Increment (CMDC)
                }
                Method (GTF, 2, Serialized)
                {
                    Store ("GTF_Entry", Debug)
                    Store (Arg1, Debug)
                    Store (Zero, CMDC)
                    Name (ID49, 0x0C00)
                    Name (ID59, Zero)
                    Name (ID53, 0x04)
                    Name (ID63, 0x0F00)
                    Name (ID88, 0x0F00)
                    Name (IRDY, One)
                    Name (PIOT, Zero)
                    Name (DMAT, Zero)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
                        CreateWordField (Arg1, 0x62, IW49)
                        Store (IW49, ID49)
                        CreateWordField (Arg1, 0x6A, IW53)
                        Store (IW53, ID53)
                        CreateWordField (Arg1, 0x7E, IW63)
                        Store (IW63, ID63)
                        CreateWordField (Arg1, 0x76, IW59)
                        Store (IW59, ID59)
                        CreateWordField (Arg1, 0xB0, IW88)
                        Store (IW88, ID88)
                    }
                    Store (0xA0, Local7)
                    If (Arg0)
                    {
                        Store (0xB0, Local7)
                        And (CHNF, 0x08, IRDY)
                        If (And (CHNF, 0x10))
                        {
                            Store (PIO1, PIOT)
                        }
                        Else
                        {
                            Store (PIO0, PIOT)
                        }
                        If (And (CHNF, 0x04))
                        {
                            If (And (CHNF, 0x10))
                            {
                                Store (DMA1, DMAT)
                            }
                            Else
                            {
                                Store (DMA0, DMAT)
                            }
                        }
                    }
                    Else
                    {
                        And (CHNF, 0x02, IRDY)
                        Store (PIO0, PIOT)
                        If (And (CHNF, One))
                        {
                            Store (DMA0, DMAT)
                        }
                    }
                    If (LAnd (LAnd (And (ID53, 0x04), And (ID88, 0xFF00
                        )), DMAT))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x02)), MLE, DMAT, MTR, 
                            Zero, Zero), Local1)
                        If (LGreater (Local1, 0x06))
                        {
                            Store (0x06, Local1)
                        }
                        GTFB (AT01, Or (0x40, Local1), Local7)
                    }
                    Else
                    {
                        If (LAnd (And (ID63, 0xFF00), PIOT))
                        {
                            And (Match (DerefOf (Index (TIM0, Zero)), MGE, PIOT, MTR, 
                                Zero, Zero), 0x03, Local0)
                            Or (0x20, DerefOf (Index (DerefOf (Index (TIM0, 0x04)), Local0
                                )), Local1)
                            GTFB (AT01, Local1, Local7)
                        }
                    }
                    If (IRDY)
                    {
                        And (Match (DerefOf (Index (TIM0, Zero)), MGE, PIOT, MTR, 
                            Zero, Zero), 0x07, Local0)
                        Or (0x08, DerefOf (Index (DerefOf (Index (TIM0, 0x03)), Local0
                            )), Local1)
                        GTFB (AT01, Local1, Local7)
                    }
                    Else
                    {
                        If (And (ID49, 0x0400))
                        {
                            GTFB (AT01, One, Local7)
                        }
                    }
                    If (LAnd (And (ID59, 0x0100), And (ID59, 0xFF)))
                    {
                        GTFB (AT03, And (ID59, 0xFF), Local7)
                    }
                    Store ("ATAB_GTF", Debug)
                    Store (ATAB, Debug)
                    Return (ATAB)
                }
                Method (RATA, 1, NotSerialized)
                {
                    CreateByteField (Arg0, Zero, CMDN)
                    Multiply (CMDN, 0x38, Local0)
                    CreateField (Arg0, 0x08, Local0, RETB)
                    Store (RETB, Debug)
                    Return (RETB)
                }
            }
            Device (ATA0)
            {
                Name (_ADR, 0x00090000)
                Device (PRI0)
                {
                    Name (_ADR, Zero)
                    Name (SPTM, Buffer (0x14)
                    {
                        /* 0000 */   0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
                        /* 0008 */   0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
                        /* 0010 */   0x17, 0x00, 0x00, 0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Return (SPTM)
                    }
                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, SPTM)
                    }
                    Device (MAST)
                    {
                        Name (_ADR, Zero)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                     0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local0)
                            Return (Concatenate (Local0, FZTF))
                        }
                    }
                    Device (SLAV)
                    {
                        Name (_ADR, One)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                     0x03, 0x46, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local0)
                            Return (Concatenate (Local0, FZTF))
                        }
                    }
                }
                Device (SEC0)
                {
                    Name (_ADR, One)
                    Name (SSTM, Buffer (0x14)
                    {
                        /* 0000 */   0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
                        /* 0008 */   0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
                        /* 0010 */   0x17, 0x00, 0x00, 0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Return (SSTM)
                    }
                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, SSTM)
                    }
                    Device (MAST)
                    {
                        Name (_ADR, Zero)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                     0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF
                                }, Local0)
                            Return (Concatenate (Local0, FZTF))
                        }
                    }
                    Device (SLAV)
                    {
                        Name (_ADR, One)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Store (Buffer (0x07)
                                {
                                     0x03, 0x46, 0x00, 0x00, 0x00, 0xB0, 0xEF
                                }, Local0)
                            Return (Concatenate (Local0, FZTF))
                        }
                    }
                }
                Method (DRMP, 0, NotSerialized)
                {
                    Store (0x08, Local0)
                    ShiftRight (CPB0, Local0, Local1)
                    And (Local1, 0x3F, Local0)
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
                Device (IGPU)
                {
                    Name (_ADR, Zero)
                    Scope (^^^PCI0)
                    {
                        OperationRegion (HDCP, SystemMemory, 0xDFFBE214, 0x0260)
                        Field (HDCP, AnyAcc, NoLock, Preserve)
                        {
                            SIGN,   48, 
                            CHKS,   8, 
                            RESR,   8, 
                            GLOB,   4800
                        }
                    }
                    Scope (^^^PCI0)
                    {
                        Device (WMI0)
                        {
                            Name (_HID, EisaId ("PNP0C14"))
                            Name (_UID, "NVIF")
                            Name (_WDG, Buffer (0x3C)
                            {
                                /* 0000 */   0xF2, 0x9A, 0x79, 0xA1, 0x29, 0x94, 0x29, 0x45,
                                /* 0008 */   0x92, 0x7E, 0xDF, 0xE1, 0x37, 0x36, 0xEE, 0xBA,
                                /* 0010 */   0x4E, 0x56, 0x01, 0x02, 0xCA, 0x9A, 0x79, 0xA1,
                                /* 0018 */   0x29, 0x94, 0x29, 0x45, 0x92, 0x7E, 0xDF, 0xE1,
                                /* 0020 */   0x37, 0x36, 0xEE, 0xBA, 0xCA, 0x00, 0x00, 0x08,
                                /* 0028 */   0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11,
                                /* 0030 */   0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10,
                                /* 0038 */   0x42, 0x41, 0x01, 0x00
                            })
                            Method (WMNV, 3, NotSerialized)
                            {
                                Store ("WMNV: ", Debug)
                                If (LGreaterEqual (SizeOf (Arg2), 0x08))
                                {
                                    CreateDWordField (Arg2, Zero, FUNC)
                                    CreateDWordField (Arg2, 0x04, SUBF)
                                    If (LGreater (SizeOf (Arg2), 0x08))
                                    {
                                        Subtract (SizeOf (Arg2), 0x08, Local2)
                                        ShiftLeft (Local2, 0x03, Local2)
                                    }
                                    CreateField (Arg2, 0x40, Local2, ARGS)
                                    Store (FUNC, Debug)
                                    Store (SUBF, Debug)
                                    Store (ARGS, Debug)
                                    Return (^^IXVE.IGPU.NVIF (FUNC, SUBF, ARGS))
                                }
                                Return (Zero)
                            }
                            Name (WQBA, Buffer (0x025D)
                            {
                                /* 0000 */   0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,
                                /* 0008 */   0x4D, 0x02, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00,
                                /* 0010 */   0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,
                                /* 0018 */   0x18, 0xCF, 0x83, 0x00, 0x01, 0x06, 0x18, 0x42,
                                /* 0020 */   0x10, 0x05, 0x10, 0x8A, 0xE6, 0x80, 0x42, 0x04,
                                /* 0028 */   0x92, 0x43, 0xA4, 0x30, 0x30, 0x28, 0x0B, 0x20,
                                /* 0030 */   0x86, 0x90, 0x0B, 0x26, 0x26, 0x40, 0x04, 0x84,
                                /* 0038 */   0xBC, 0x0A, 0xB0, 0x29, 0xC0, 0x24, 0x88, 0xFA,
                                /* 0040 */   0xF7, 0x87, 0x28, 0x09, 0x0E, 0x25, 0x04, 0x42,
                                /* 0048 */   0x12, 0x05, 0x98, 0x17, 0xA0, 0x5B, 0x80, 0x61,
                                /* 0050 */   0x01, 0xB6, 0x05, 0x98, 0x16, 0xE0, 0x18, 0x92,
                                /* 0058 */   0x4A, 0x03, 0xA7, 0x04, 0x96, 0x02, 0x21, 0xA1,
                                /* 0060 */   0x02, 0x94, 0x0B, 0xF0, 0x2D, 0x40, 0x3B, 0xA2,
                                /* 0068 */   0x24, 0x0B, 0xB0, 0x0C, 0x23, 0x02, 0x8F, 0x82,
                                /* 0070 */   0xA1, 0x71, 0x68, 0xEC, 0x30, 0x2C, 0x13, 0x4C,
                                /* 0078 */   0x83, 0x38, 0x8C, 0xB2, 0x91, 0x45, 0x60, 0xDC,
                                /* 0080 */   0x4E, 0x05, 0xC8, 0x15, 0x20, 0x4C, 0x80, 0x78,
                                /* 0088 */   0x54, 0x61, 0x34, 0x07, 0x45, 0xE0, 0x42, 0x63,
                                /* 0090 */   0x64, 0x40, 0xC8, 0xA3, 0x00, 0xAB, 0xA3, 0xD0,
                                /* 0098 */   0xA4, 0x12, 0xD8, 0xBD, 0x00, 0x83, 0x02, 0x8C,
                                /* 00A0 */   0x09, 0xF0, 0x86, 0x2A, 0x84, 0x28, 0x35, 0x0A,
                                /* 00A8 */   0x50, 0x26, 0xC0, 0x16, 0x8A, 0xE0, 0x83, 0xC4,
                                /* 00B0 */   0x88, 0x12, 0xA4, 0x35, 0x14, 0x0A, 0x11, 0x24,
                                /* 00B8 */   0x66, 0x8B, 0x28, 0x02, 0x8F, 0x19, 0x24, 0x74,
                                /* 00C0 */   0x67, 0x40, 0x82, 0xA8, 0x0D, 0x46, 0x08, 0x15,
                                /* 00C8 */   0xC2, 0xCB, 0xFE, 0x20, 0x88, 0xFC, 0xD5, 0x6B,
                                /* 00D0 */   0xDC, 0x8E, 0x34, 0x1A, 0xD4, 0x58, 0x13, 0x1C,
                                /* 00D8 */   0xBB, 0x47, 0x73, 0xC2, 0x9D, 0x0B, 0x90, 0x3E,
                                /* 00E0 */   0x37, 0x81, 0x1C, 0xDD, 0xC1, 0xD5, 0x39, 0x68,
                                /* 00E8 */   0x32, 0x3C, 0x86, 0x95, 0xE0, 0x3F, 0xC0, 0xA7,
                                /* 00F0 */   0x00, 0xBC, 0x6B, 0x40, 0x4D, 0xFF, 0xE0, 0x99,
                                /* 00F8 */   0x20, 0x38, 0xD4, 0x10, 0x3D, 0xEA, 0x70, 0x27,
                                /* 0100 */   0x70, 0xEC, 0x47, 0xC2, 0x20, 0x0E, 0xF6, 0xB8,
                                /* 0108 */   0xB1, 0x0E, 0x27, 0xA3, 0x41, 0x97, 0x2A, 0xC0,
                                /* 0110 */   0xEC, 0x01, 0x40, 0x23, 0x4B, 0x70, 0xDA, 0x67,
                                /* 0118 */   0x12, 0xFA, 0x3D, 0xE0, 0x7C, 0x7A, 0x1E, 0x1B,
                                /* 0120 */   0x1B, 0x04, 0x6A, 0x64, 0xFE, 0xFF, 0x43, 0x7B,
                                /* 0128 */   0x88, 0xA7, 0x15, 0x33, 0xE4, 0xB3, 0xC0, 0x61,
                                /* 0130 */   0x31, 0xB1, 0x47, 0x06, 0x3A, 0x1E, 0xF0, 0x4F,
                                /* 0138 */   0xFC, 0xD1, 0x20, 0xC2, 0x9B, 0x81, 0xE7, 0x6B,
                                /* 0140 */   0x82, 0x41, 0x21, 0xE4, 0x64, 0x3C, 0x28, 0x31,
                                /* 0148 */   0x20, 0x1A, 0x74, 0xAD, 0xD8, 0xBA, 0x07, 0x04,
                                /* 0150 */   0x8F, 0x79, 0x44, 0x45, 0x03, 0x6B, 0x20, 0xEC,
                                /* 0158 */   0x0C, 0xE0, 0x71, 0x5B, 0x16, 0x08, 0x25, 0x30,
                                /* 0160 */   0xB0, 0xCF, 0x0D, 0xEF, 0x10, 0xC6, 0xC5, 0xE1,
                                /* 0168 */   0x47, 0xF6, 0xF9, 0xC2, 0x02, 0x07, 0x85, 0x82,
                                /* 0170 */   0xF5, 0xED, 0x20, 0xE6, 0xF3, 0xC0, 0x71, 0x1E,
                                /* 0178 */   0xB0, 0x85, 0x4F, 0x94, 0x00, 0x1F, 0x92, 0x47,
                                /* 0180 */   0x03, 0x6F, 0x90, 0xF0, 0xAD, 0x1F, 0x01, 0x08,
                                /* 0188 */   0xF2, 0x0B, 0xC3, 0x63, 0x43, 0x02, 0xCB, 0x03,
                                /* 0190 */   0x46, 0x8F, 0xD2, 0x7E, 0x05, 0x20, 0x04, 0x7F,
                                /* 0198 */   0xB1, 0x78, 0x0A, 0x78, 0x1D, 0x88, 0x70, 0x2C,
                                /* 01A0 */   0x30, 0x45, 0x8E, 0x0D, 0x0D, 0xCF, 0x81, 0xA3,
                                /* 01A8 */   0x87, 0x3D, 0x97, 0xF0, 0x47, 0x13, 0xE5, 0x14,
                                /* 01B0 */   0x0E, 0xC7, 0x47, 0x0E, 0x23, 0xC4, 0x7F, 0xD2,
                                /* 01B8 */   0x78, 0xF2, 0xB0, 0xE6, 0x3B, 0x80, 0xA6, 0xF4,
                                /* 01C0 */   0x16, 0xF0, 0xFE, 0xE0, 0x11, 0x60, 0xA2, 0x1F,
                                /* 01C8 */   0x4D, 0x50, 0x61, 0x4F, 0x27, 0xA0, 0xFA, 0xFF,
                                /* 01D0 */   0x9F, 0x4E, 0x00, 0x6B, 0xC3, 0x0E, 0xF1, 0x74,
                                /* 01D8 */   0x02, 0xF6, 0x78, 0x0F, 0x0D, 0x69, 0x38, 0x9D,
                                /* 01E0 */   0x00, 0x14, 0xF8, 0xFF, 0x9F, 0x4E, 0xE0, 0xC7,
                                /* 01E8 */   0x3C, 0x9D, 0x40, 0x05, 0x3E, 0x1F, 0x5F, 0x3A,
                                /* 01F0 */   0x7C, 0x28, 0x30, 0xC1, 0x40, 0xE3, 0xA6, 0xA2,
                                /* 01F8 */   0x4E, 0x27, 0xA8, 0xC3, 0x83, 0x4F, 0x27, 0xEC,
                                /* 0200 */   0x50, 0x70, 0x12, 0x4F, 0x01, 0x3E, 0x9C, 0x80,
                                /* 0208 */   0x79, 0x30, 0xF8, 0xC3, 0x09, 0x70, 0x1B, 0x0B,
                                /* 0210 */   0xFE, 0x70, 0x02, 0x3C, 0xEE, 0x18, 0x1E, 0x02,
                                /* 0218 */   0x3F, 0x41, 0x78, 0x08, 0x7C, 0x00, 0xCF, 0x1A,
                                /* 0220 */   0x67, 0x67, 0xA5, 0x73, 0x42, 0x1E, 0x43, 0xF8,
                                /* 0228 */   0x9C, 0x30, 0xA7, 0x15, 0x9C, 0x42, 0x9B, 0x3E,
                                /* 0230 */   0x35, 0x1A, 0xB5, 0x6A, 0x50, 0xA6, 0x46, 0x99,
                                /* 0238 */   0x06, 0xB5, 0xFA, 0x54, 0x6A, 0xCC, 0xD8, 0x21,
                                /* 0240 */   0xC3, 0x01, 0x9F, 0x01, 0x3A, 0x0F, 0x58, 0xDE,
                                /* 0248 */   0x9B, 0x41, 0x20, 0x96, 0x41, 0x21, 0x10, 0x4B,
                                /* 0250 */   0x7F, 0xB2, 0x08, 0xC4, 0xC1, 0x41, 0x68, 0x3C,
                                /* 0258 */   0x5A, 0x81, 0xF8, 0xFF, 0x0F
                            })
                        }
                    }
                    Name (ERR0, Buffer (0x04)
                    {
                         0x00, 0x00, 0x00, 0x00
                    })
                    Name (ERR1, Buffer (0x04)
                    {
                         0x01, 0x00, 0x00, 0x80
                    })
                    Name (VER1, Buffer (0x04)
                    {
                         0x01, 0x00, 0x00, 0x00
                    })
                    Method (NVIF, 3, NotSerialized)
                    {
                        Store (ERR1, Local0)
                        If (LEqual (Arg0, One))
                        {
                            Concatenate (ERR0, VER1, Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x0C))
                            {
                                If (LEqual (Arg1, Zero))
                                {
                                    Store (ERR0, Local0)
                                }
                                Else
                                {
                                    If (LEqual (Arg1, One))
                                    {
                                        Store (GLOB, Local1)
                                        Concatenate (ERR0, Local1, Local0)
                                    }
                                }
                            }
                            If (LEqual (Arg0, 0x0D))
                            {
                                If (LEqual (Arg1, Zero))
                                {
                                    Store (ERR0, Local0)
                                }
                                Else
                                {
                                    If (LEqual (Arg1, 0x03))
                                    {
                                        Name (BFD1, Buffer (0x06)
                                        {
                                             0x10, 0x06, 0x01, 0x06, 0x00, 0x00
                                        })
                                        CreateField (BFD1, 0x20, 0x10, SVMS)
                                        Store (0x40, SVMS)
                                        Concatenate (ERR0, BFD1, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg1, 0x02))
                                        {
                                            Store (IMPM (), Local1)
                                            Concatenate (ERR0, Local1, Local0)
                                        }
                                    }
                                }
                            }
                        }
                        Return (Local0)
                    }
                    Scope (^^^PCI0)
                    {
                        Device (K800)
                        {
                            Name (_ADR, 0x00180000)
                            OperationRegion (HTWF, PCI_Config, 0x84, 0x20)
                            Field (HTWF, ByteAcc, NoLock, Preserve)
                            {
                                    ,   28, 
                                LDTW,   3, 
                                Offset (0x04), 
                                Offset (0x05), 
                                LDTF,   4
                            }
                        }
                        Device (K802)
                        {
                            Name (_ADR, 0x00180002)
                            OperationRegion (HMM2, PCI_Config, 0x90, 0x08)
                            Field (HMM2, ByteAcc, NoLock, Preserve)
                            {
                                    ,   11, 
                                MEMW,   1, 
                                Offset (0x04), 
                                MCLK,   3, 
                                Offset (0x05), 
                                DDRM,   1
                            }
                            OperationRegion (G040, PCI_Config, 0x40, 0x20)
                            Field (G040, AnyAcc, NoLock, Preserve)
                            {
                                RR22,   1, 
                                    ,   18, 
                                RR23,   10, 
                                Offset (0x04), 
                                RR24,   1, 
                                    ,   18, 
                                RR25,   10, 
                                Offset (0x08), 
                                RR26,   1, 
                                    ,   18, 
                                RR27,   10, 
                                Offset (0x0C), 
                                RR28,   1, 
                                    ,   18, 
                                RR29,   10, 
                                Offset (0x10), 
                                RB22,   1, 
                                    ,   18, 
                                RB23,   10, 
                                Offset (0x14), 
                                RB24,   1, 
                                    ,   18, 
                                RB25,   10, 
                                Offset (0x18), 
                                RB26,   1, 
                                    ,   18, 
                                RB27,   10, 
                                Offset (0x1C), 
                                RB28,   1, 
                                    ,   18, 
                                RB29,   10, 
                                Offset (0x20)
                            }
                            Field (G040, AnyAcc, NoLock, Preserve)
                            {
                                CSE0,   1, 
                                    ,   4, 
                                BAL0,   9, 
                                Offset (0x04), 
                                CSE1,   1, 
                                    ,   4, 
                                BAL1,   9, 
                                Offset (0x08), 
                                CSE2,   1, 
                                    ,   4, 
                                BAL2,   9, 
                                Offset (0x0C), 
                                CSE3,   1, 
                                    ,   4, 
                                BAL3,   9, 
                                Offset (0x10), 
                                CSE4,   1, 
                                    ,   4, 
                                BAL4,   9, 
                                Offset (0x14), 
                                CSE5,   1, 
                                    ,   4, 
                                BAL5,   9, 
                                Offset (0x18), 
                                CSE6,   1, 
                                    ,   4, 
                                BAL6,   9, 
                                Offset (0x1C), 
                                CSE7,   1, 
                                    ,   4, 
                                BAL7,   9
                            }
                            OperationRegion (G080, PCI_Config, 0x80, 0x04)
                            Field (G080, AnyAcc, NoLock, Preserve)
                            {
                                RR30,   4, 
                                RR31,   4
                            }
                            Field (G080, AnyAcc, NoLock, Preserve)
                            {
                                CS10,   4, 
                                CS32,   4, 
                                CS54,   4, 
                                CS76,   4
                            }
                        }
                        Device (K803)
                        {
                            Name (_ADR, 0x00180003)
                            OperationRegion (HMM3, PCI_Config, 0x80, 0x04)
                            Field (HMM3, ByteAcc, NoLock, Preserve)
                            {
                                PMM0,   8, 
                                PM1A,   4, 
                                PM1C,   3
                            }
                        }
                        OperationRegion (NVBF, SystemMemory, 0xDFFBE0E4, 0x0100)
                        Field (NVBF, AnyAcc, NoLock, Preserve)
                        {
                            M2BW,   12, 
                                ,   8, 
                            K10F,   8, 
                            Offset (0x04), 
                            TOM1,   32, 
                            TOM2,   32, 
                            Offset (0x0D), 
                            LSMD,   1, 
                            Offset (0x10), 
                            RR10,   1, 
                                ,   1, 
                            RR11,   1, 
                                ,   1, 
                            RR12,   1, 
                                ,   6, 
                            RR13,   21, 
                            Offset (0x40), 
                            RR14,   1, 
                                ,   18, 
                            RR15,   10, 
                            Offset (0x44), 
                            RR16,   1, 
                                ,   18, 
                            RR17,   10, 
                            Offset (0x48), 
                            RR18,   1, 
                                ,   18, 
                            RR19,   10, 
                            Offset (0x4C), 
                            RR20,   1, 
                                ,   18, 
                            RR21,   10, 
                            Offset (0x50), 
                            RB14,   1, 
                                ,   18, 
                            RB15,   10, 
                            Offset (0x54), 
                            RB16,   1, 
                                ,   18, 
                            RB17,   10, 
                            Offset (0x58), 
                            RB18,   1, 
                                ,   18, 
                            RB19,   10, 
                            Offset (0x5C), 
                            RB20,   1, 
                                ,   18, 
                            RB21,   10, 
                            Offset (0x60), 
                            Offset (0x80), 
                            RR32,   4, 
                            RR33,   4, 
                            Offset (0x94), 
                            Offset (0x95), 
                            YDDR,   1
                        }
                        Method (GTOM, 0, NotSerialized)
                        {
                            If (TOM2)
                            {
                                Return (TOM2)
                            }
                            Else
                            {
                                Return (TOM1)
                            }
                        }
                        Method (PBNK, 2, NotSerialized)
                        {
                            Store (Zero, Local2)
                            If (Arg0)
                            {
                                If (LLess (Arg1, 0x02))
                                {
                                    Store (RR32, Local1)
                                }
                                Else
                                {
                                    Store (RR33, Local1)
                                }
                                If (YDDR)
                                {
                                    Store (One, Local2)
                                }
                            }
                            Else
                            {
                                If (LLess (Arg1, 0x02))
                                {
                                    Store (^K802.RR30, Local1)
                                }
                                Else
                                {
                                    Store (^K802.RR31, Local1)
                                }
                                If (^K802.DDRM)
                                {
                                    Store (One, Local2)
                                }
                            }
                            If (Local2)
                            {
                                Return (DBK2 (Local1))
                            }
                            Else
                            {
                                Return (DBNK (Local1))
                            }
                        }
                        Method (PCOL, 2, NotSerialized)
                        {
                            Store (Zero, Local2)
                            If (Arg0)
                            {
                                If (LLess (Arg1, 0x02))
                                {
                                    Store (RR32, Local1)
                                }
                                Else
                                {
                                    Store (RR33, Local1)
                                }
                                If (YDDR)
                                {
                                    Store (One, Local2)
                                }
                            }
                            Else
                            {
                                If (LLess (Arg1, 0x02))
                                {
                                    Store (^K802.RR30, Local1)
                                }
                                Else
                                {
                                    Store (^K802.RR31, Local1)
                                }
                                If (^K802.DDRM)
                                {
                                    Store (One, Local2)
                                }
                            }
                            If (Local2)
                            {
                                Return (DCL2 (Local1))
                            }
                            Else
                            {
                                Return (DCOL (Local1))
                            }
                        }
                        Method (DBNK, 1, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (Arg0, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (0x02)
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Return (0x02)
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x02))
                                    {
                                        Return (0x02)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x03))
                                        {
                                            Return (0x02)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x04))
                                            {
                                                Return (0x03)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT0, 0x05))
                                                {
                                                    Return (0x03)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT0, 0x06))
                                                    {
                                                        Return (0x02)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT0, 0x07))
                                                        {
                                                            Return (0x03)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT0, 0x08))
                                                            {
                                                                Return (0x03)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (TTT0, 0x09))
                                                                {
                                                                    Return (0x03)
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (TTT0, 0x0A))
                                                                    {
                                                                        Return (0x03)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (TTT0, 0x0B))
                                                                        {
                                                                            Return (0x03)
                                                                        }
                                                                        Else
                                                                        {
                                                                            Return (0x02)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Method (DBK2, 1, NotSerialized)
                        {
                            Return (0x03)
                        }
                        Method (DCOL, 1, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (Arg0, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Return (0x0A)
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x02))
                                    {
                                        Return (0x0A)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x03))
                                        {
                                            Return (0x0B)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x04))
                                            {
                                                Return (0x0A)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT0, 0x05))
                                                {
                                                    Return (0x0A)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT0, 0x06))
                                                    {
                                                        Return (0x0B)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT0, 0x07))
                                                        {
                                                            Return (0x0A)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT0, 0x08))
                                                            {
                                                                Return (0x0B)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (TTT0, 0x09))
                                                                {
                                                                    Return (0x0B)
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (TTT0, 0x0A))
                                                                    {
                                                                        Return (0x0A)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (TTT0, 0x0B))
                                                                        {
                                                                            Return (0x0B)
                                                                        }
                                                                        Else
                                                                        {
                                                                            Return (0x0A)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Method (DCL2, 1, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (Arg0, TTT0)
                            If (LEqual (TTT0, One))
                            {
                                Return (0x0A)
                            }
                            Else
                            {
                                If (LEqual (TTT0, 0x02))
                                {
                                    Return (0x0A)
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x05))
                                    {
                                        Return (0x0A)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x06))
                                        {
                                            Return (0x0B)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x07))
                                            {
                                                Return (0x0A)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT0, 0x08))
                                                {
                                                    Return (0x0B)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT0, 0x09))
                                                    {
                                                        Return (0x0B)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT0, 0x0A))
                                                        {
                                                            Return (0x0A)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT0, 0x0B))
                                                            {
                                                                Return (0x0B)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (TTT0, 0x0C))
                                                                {
                                                                    Return (0x0B)
                                                                }
                                                                Else
                                                                {
                                                                    Return (0x0A)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Method (RNKP, 2, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (Arg0, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Name (TTT1, Zero)
                                Store (Arg1, TTT1)
                                If (LEqual (TTT1, Zero))
                                {
                                    Return (^K802.RR22)
                                }
                                Else
                                {
                                    If (LEqual (TTT1, One))
                                    {
                                        Return (^K802.RR24)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT1, 0x02))
                                        {
                                            Return (^K802.RR26)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT1, 0x03))
                                            {
                                                Return (^K802.RR28)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT1, 0x04))
                                                {
                                                    Return (^K802.RB22)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT1, 0x05))
                                                    {
                                                        Return (^K802.RB24)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT1, 0x06))
                                                        {
                                                            Return (^K802.RB26)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT1, 0x07))
                                                            {
                                                                Return (^K802.RB28)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Name (TTT2, Zero)
                                    Store (Arg1, TTT2)
                                    If (LEqual (TTT2, Zero))
                                    {
                                        Return (RR14)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT2, One))
                                        {
                                            Return (RR16)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT2, 0x02))
                                            {
                                                Return (RR18)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT2, 0x03))
                                                {
                                                    Return (RR20)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT2, 0x04))
                                                    {
                                                        Return (RB14)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT2, 0x05))
                                                        {
                                                            Return (RB16)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT2, 0x06))
                                                            {
                                                                Return (RB18)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (TTT2, 0x07))
                                                                {
                                                                    Return (RB20)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Return (Zero)
                        }
                        Method (STAD, 2, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (Arg0, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Name (TTT1, Zero)
                                Store (Arg1, TTT1)
                                If (LEqual (TTT1, Zero))
                                {
                                    Return (^K802.RR23)
                                }
                                Else
                                {
                                    If (LEqual (TTT1, One))
                                    {
                                        Return (^K802.RR25)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT1, 0x02))
                                        {
                                            Return (^K802.RR27)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT1, 0x03))
                                            {
                                                Return (^K802.RR29)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT1, 0x04))
                                                {
                                                    Return (^K802.RB23)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT1, 0x05))
                                                    {
                                                        Return (^K802.RB25)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT1, 0x06))
                                                        {
                                                            Return (^K802.RB27)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT1, 0x07))
                                                            {
                                                                Return (^K802.RB29)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Name (TTT2, Zero)
                                    Store (Arg1, TTT2)
                                    If (LEqual (TTT2, Zero))
                                    {
                                        Return (RR15)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT2, One))
                                        {
                                            Return (RR17)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT2, 0x02))
                                            {
                                                Return (RR19)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT2, 0x03))
                                                {
                                                    Return (RR21)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT2, 0x04))
                                                    {
                                                        Return (RB15)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT2, 0x05))
                                                        {
                                                            Return (RB17)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT2, 0x06))
                                                            {
                                                                Return (RB19)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (TTT2, 0x07))
                                                                {
                                                                    Return (RB21)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Return (Zero)
                        }
                        Method (GLDT, 0, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (^K800.LDTF, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (0xC8)
                            }
                            Else
                            {
                                If (LEqual (TTT0, 0x02))
                                {
                                    Return (0x0190)
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x04))
                                    {
                                        Return (0x0258)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x05))
                                        {
                                            Return (0x0320)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x06))
                                            {
                                                Return (0x03E8)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT0, 0x07))
                                                {
                                                    Return (0x04B0)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT0, 0x08))
                                                    {
                                                        Return (0x0578)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT0, 0x09))
                                                        {
                                                            Return (0x0640)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT0, 0x0A))
                                                            {
                                                                Return (0x0708)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (TTT0, 0x0B))
                                                                {
                                                                    Return (0x07D0)
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (TTT0, 0x0C))
                                                                    {
                                                                        Return (0x0898)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (TTT0, 0x0D))
                                                                        {
                                                                            Return (0x0960)
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (TTT0, 0x0E))
                                                                            {
                                                                                Return (0x0A28)
                                                                            }
                                                                            Else
                                                                            {
                                                                                If (LEqual (TTT0, 0x11))
                                                                                {
                                                                                    Return (0x0AF0)
                                                                                }
                                                                                Else
                                                                                {
                                                                                    If (LEqual (TTT0, 0x12))
                                                                                    {
                                                                                        Return (0x0BB8)
                                                                                    }
                                                                                    Else
                                                                                    {
                                                                                        If (LEqual (TTT0, 0x13))
                                                                                        {
                                                                                            Return (0x0C80)
                                                                                        }
                                                                                        Else
                                                                                        {
                                                                                            Return (0x03E8)
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Method (GLDW, 0, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (^K800.LDTW, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (0x08)
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Return (0x10)
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x04))
                                    {
                                        Return (0x02)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x05))
                                        {
                                            Return (0x04)
                                        }
                                        Else
                                        {
                                            Return (0x08)
                                        }
                                    }
                                }
                            }
                        }
                        Method (PCS8, 1, NotSerialized)
                        {
                            If (LLess (Arg0, 0x02))
                            {
                                Store (^K802.CS10, Local0)
                            }
                            Else
                            {
                                If (LLess (Arg0, 0x04))
                                {
                                    Store (^K802.CS32, Local0)
                                }
                                Else
                                {
                                    If (LLess (Arg0, 0x06))
                                    {
                                        Store (^K802.CS54, Local0)
                                    }
                                    Else
                                    {
                                        Store (^K802.CS76, Local0)
                                    }
                                }
                            }
                            Name (TTT0, Zero)
                            Store (Local0, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (Package (0x03)
                                {
                                    0x02, 
                                    0x09, 
                                    0x80
                                })
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Return (Package (0x03)
                                    {
                                        0x02, 
                                        0x0A, 
                                        0x0100
                                    })
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x02))
                                    {
                                        Return (Package (0x03)
                                        {
                                            0x02, 
                                            0x0A, 
                                            0x0200
                                        })
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x03))
                                        {
                                            Return (Package (0x03)
                                            {
                                                0x02, 
                                                0x0B, 
                                                0x0200
                                            })
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x04))
                                            {
                                                Return (Package (0x03)
                                                {
                                                    0x03, 
                                                    0x0A, 
                                                    0x0200
                                                })
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT0, 0x05))
                                                {
                                                    Return (Package (0x03)
                                                    {
                                                        0x03, 
                                                        0x0A, 
                                                        0x0400
                                                    })
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT0, 0x06))
                                                    {
                                                        Return (Package (0x03)
                                                        {
                                                            0x02, 
                                                            0x0B, 
                                                            0x0400
                                                        })
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT0, 0x07))
                                                        {
                                                            Return (Package (0x03)
                                                            {
                                                                0x03, 
                                                                0x0A, 
                                                                0x0800
                                                            })
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT0, 0x08))
                                                            {
                                                                Return (Package (0x03)
                                                                {
                                                                    0x03, 
                                                                    0x0B, 
                                                                    0x0800
                                                                })
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (TTT0, 0x09))
                                                                {
                                                                    Return (Package (0x03)
                                                                    {
                                                                        0x03, 
                                                                        0x0B, 
                                                                        0x1000
                                                                    })
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (TTT0, 0x0A))
                                                                    {
                                                                        Return (Package (0x03)
                                                                        {
                                                                            0x03, 
                                                                            0x0A, 
                                                                            0x1000
                                                                        })
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (TTT0, 0x0B))
                                                                        {
                                                                            Return (Package (0x03)
                                                                            {
                                                                                0x03, 
                                                                                0x0B, 
                                                                                0x2000
                                                                            })
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Return (Zero)
                        }
                        Method (CSE8, 1, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (Arg0, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (^K802.CSE0)
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Return (^K802.CSE1)
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x02))
                                    {
                                        Return (^K802.CSE2)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x03))
                                        {
                                            Return (^K802.CSE3)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x04))
                                            {
                                                Return (^K802.CSE4)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT0, 0x05))
                                                {
                                                    Return (^K802.CSE5)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT0, 0x06))
                                                    {
                                                        Return (^K802.CSE6)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT0, 0x07))
                                                        {
                                                            Return (^K802.CSE7)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Return (Zero)
                        }
                        Method (BAL8, 1, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (Arg0, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (^K802.BAL0)
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Return (^K802.BAL1)
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x02))
                                    {
                                        Return (^K802.BAL2)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x03))
                                        {
                                            Return (^K802.BAL3)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x04))
                                            {
                                                Return (^K802.BAL4)
                                            }
                                            Else
                                            {
                                                If (LEqual (TTT0, 0x05))
                                                {
                                                    Return (^K802.BAL5)
                                                }
                                                Else
                                                {
                                                    If (LEqual (TTT0, 0x06))
                                                    {
                                                        Return (^K802.BAL6)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT0, 0x07))
                                                        {
                                                            Return (^K802.BAL7)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Return (Zero)
                        }
                        Method (GTBW, 2, NotSerialized)
                        {
                            Store (GMCK (), Local1)
                            Multiply (Local1, 0x08, Local1)
                            Divide (Local1, 0x0A, Local1, Local2)
                            Multiply (0x0DAC, Arg0, Local3)
                            Multiply (Local3, Arg1, Local3)
                            Divide (Local3, 0x00027100, Local3, Local4)
                            If (LGreater (Local4, Local2))
                            {
                                Store (Local2, Local4)
                            }
                            Return (Local4)
                        }
                        Method (GLBW, 2, NotSerialized)
                        {
                            Multiply (0x0DAC, Arg0, Local3)
                            Multiply (Local3, Arg1, Local3)
                            Divide (Local3, 0x00027100, Local3, Local4)
                            Return (Local4)
                        }
                        Method (GMCK, 0, NotSerialized)
                        {
                            Name (TTT0, Zero)
                            Store (^K802.MCLK, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (0xC8)
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    Return (0x010A)
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x02))
                                    {
                                        Return (0x014D)
                                    }
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x03))
                                        {
                                            Return (0x0190)
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x04))
                                            {
                                                Return (0x0215)
                                            }
                                            Else
                                            {
                                                Return (0x014D)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Method (ATB8, 2, NotSerialized)
                        {
                            Store (0x10, Local2)
                            Multiply (0x0DAC, Arg0, Local2)
                            Multiply (Local2, Arg1, Local2)
                            Divide (Local2, 0x00027100, Local2, Local3)
                            If (LGreater (Local3, M2BW))
                            {
                                Store (M2BW, Local3)
                            }
                            Return (Local3)
                        }
                        Method (IMPM, 0, NotSerialized)
                        {
                            Name (BU2A, Buffer (0x04)
                            {
                                 0x00
                            })
                            CreateField (BU2A, 0x10, 0x04, BF03)
                            CreateField (BU2A, 0x14, 0x04, BF04)
                            Name (BU2B, Buffer (0x04)
                            {
                                 0x00
                            })
                            CreateField (BU2B, Zero, 0x0B, BF07)
                            CreateField (BU2B, 0x0B, 0x0E, BF08)
                            Name (BU2C, Buffer (0x0A)
                            {
                                 0x00
                            })
                            CreateField (BU2C, Zero, 0x03, BF0A)
                            CreateField (BU2C, 0x03, 0x04, BF0B)
                            CreateField (BU2C, 0x07, 0x04, BF0C)
                            CreateField (BU2C, 0x0B, 0x04, BF0D)
                            CreateField (BU2C, 0x0F, 0x04, BF0E)
                            CreateField (BU2C, 0x13, 0x26, BF0F)
                            Name (BU2D, Buffer (0x0A)
                            {
                                 0x00
                            })
                            CreateField (BU2D, Zero, 0x10, BF1A)
                            CreateField (BU2D, 0x10, 0x0B, TAVN)
                            CreateField (BU2D, 0x1B, 0x0A, BASL)
                            CreateField (BU2D, 0x25, 0x0B, LBWF)
                            CreateField (BU2D, 0x30, 0x0C, ATBW)
                            CreateField (BU2D, 0x3C, 0x0A, CLTF)
                            CreateField (BU2D, 0x46, 0x0A, PMPF)
                            Store (0x10, Index (BU2A, Zero))
                            Store (0x08, Index (BU2A, One))
                            Store (0x11, Index (BU2A, 0x02))
                            Store (0xAA, Index (BU2A, 0x03))
                            If (K10F)
                            {
                                Name (BBB8, 0x02)
                                Name (BBB0, 0x02)
                                Name (BBB1, 0x02)
                                Name (BBB2, 0x0A)
                                Name (BBB3, 0x0A)
                                Name (BBM0, One)
                                Name (BBB9, Zero)
                                Name (BBB4, 0x02)
                                Name (BBB5, 0x02)
                                Name (BBB6, 0x0A)
                                Name (BBB7, 0x0A)
                                Name (BBM1, One)
                                Name (BBBA, Zero)
                                Name (BBBB, Zero)
                                Store (0x36B0, Local3)
                                If (LEqual (LSMD, Zero))
                                {
                                    Store (0x1388, Local3)
                                }
                                Add (Local3, 0x01F4, Local3)
                                Add (Local3, 0x2710, Local3)
                                Divide (Local3, 0x64, Local2, BF07)
                                Store (GMCK (), BF08)
                                If (RR12)
                                {
                                    Store (One, BBBA)
                                    Store (Zero, Local1)
                                    While (One)
                                    {
                                        If (RNKP (Zero, Local1))
                                        {
                                            Store (PBNK (Zero, Local1), Local2)
                                            If (LLess (Local2, BBB0))
                                            {
                                                Store (Local2, BBB0)
                                            }
                                            If (LGreater (Local2, BBB1))
                                            {
                                                Store (Local2, BBB1)
                                            }
                                            Store (PCOL (Zero, Local1), Local2)
                                            If (LLess (Local2, BBB2))
                                            {
                                                Store (Local2, BBB2)
                                            }
                                            If (LGreater (Local2, BBB3))
                                            {
                                                Store (Local2, BBB3)
                                            }
                                        }
                                        Increment (Local1)
                                        If (LGreater (Local1, 0x03))
                                        {
                                            Break
                                        }
                                    }
                                }
                                Else
                                {
                                    If (RR11)
                                    {
                                        Store (One, BBBA)
                                        If (RR10)
                                        {
                                            Store (0x02, BBBA)
                                            Store (One, BBB9)
                                        }
                                        Store (Zero, Local1)
                                        While (One)
                                        {
                                            Store (Zero, Local2)
                                            While (One)
                                            {
                                                If (RNKP (Local1, Local2))
                                                {
                                                    If (LOr (LLess (STAD (Local1, Local2), RR13), LEqual (RR10, Zero)))
                                                    {
                                                        Store (PBNK (Local1, Local2), Local3)
                                                        If (LLess (Local3, BBB0))
                                                        {
                                                            Store (Local3, BBB0)
                                                        }
                                                        If (LGreater (Local3, BBB1))
                                                        {
                                                            Store (Local3, BBB1)
                                                        }
                                                        Store (PCOL (Local1, Local2), Local3)
                                                        If (LLess (Local3, BBB2))
                                                        {
                                                            Store (Local3, BBB2)
                                                        }
                                                        If (LGreater (Local3, BBB3))
                                                        {
                                                            Store (Local3, BBB3)
                                                        }
                                                    }
                                                    Else
                                                    {
                                                        Store (PBNK (Local1, Local2), Local3)
                                                        If (LLess (Local3, BBB4))
                                                        {
                                                            Store (Local3, BBB4)
                                                        }
                                                        If (LGreater (Local3, BBB5))
                                                        {
                                                            Store (Local3, BBB5)
                                                        }
                                                        Store (PCOL (Local1, Local2), Local3)
                                                        If (LLess (Local3, BBB6))
                                                        {
                                                            Store (Local3, BBB6)
                                                        }
                                                        If (LGreater (Local3, BBB7))
                                                        {
                                                            Store (Local3, BBB7)
                                                        }
                                                    }
                                                }
                                                Increment (Local2)
                                                If (LGreater (Local2, 0x03))
                                                {
                                                    Break
                                                }
                                            }
                                            Increment (Local1)
                                            If (LGreater (Local1, One))
                                            {
                                                Break
                                            }
                                        }
                                    }
                                    Else
                                    {
                                        Store (One, BBBA)
                                        Store (One, BBB8)
                                        Store (Zero, Local1)
                                        While (One)
                                        {
                                            Store (Zero, Local2)
                                            While (One)
                                            {
                                                If (RNKP (Local1, Local2))
                                                {
                                                    Store (PBNK (Local1, Local2), Local3)
                                                    If (LLess (Local3, BBB0))
                                                    {
                                                        Store (Local3, BBB0)
                                                    }
                                                    If (LGreater (Local3, BBB1))
                                                    {
                                                        Store (Local3, BBB1)
                                                    }
                                                    Store (PCOL (Local1, Local2), Local3)
                                                    If (LLess (Local3, BBB2))
                                                    {
                                                        Store (Local3, BBB3)
                                                    }
                                                    If (LGreater (Local3, BBB3))
                                                    {
                                                        Store (Local3, BBB4)
                                                    }
                                                }
                                                Increment (Local2)
                                                If (LGreater (Local2, 0x03))
                                                {
                                                    Break
                                                }
                                            }
                                            Increment (Local1)
                                            If (LGreater (Local1, One))
                                            {
                                                Break
                                            }
                                        }
                                    }
                                }
                                Store (GTOM (), Local2)
                                If (RR13)
                                {
                                    Multiply (RR13, 0x08000000, Local1)
                                    Store (Local1, BBM0)
                                    Subtract (Local2, Local1, BBM1)
                                }
                                Else
                                {
                                    Store (Local2, BBM0)
                                }
                                Store (BBBA, BF03)
                                Concatenate (BU2A, BU2B, Local4)
                                Store (BBB8, BF0A)
                                Store (BBB0, BF0B)
                                Store (BBB1, BF0C)
                                Store (BBB2, BF0D)
                                Store (BBB3, BF0E)
                                Store (BBM0, BF0F)
                                Concatenate (Local4, BU2C, Local5)
                                If (LEqual (BBBA, 0x02))
                                {
                                    Store (BBB9, BF0A)
                                    Store (BBB4, BF0B)
                                    Store (BBB5, BF0C)
                                    Store (BBB6, BF0D)
                                    Store (BBB7, BF0E)
                                    Store (BBM1, BF0F)
                                    Store (Local5, Local4)
                                    Concatenate (Local4, BU2C, Local5)
                                }
                                Store (BF07, BASL)
                                Store (BASL, TAVN)
                                Store (BF08, BBBB)
                                Multiply (0x0F, 0x03E8, Local2)
                                Divide (Local2, BBBB, Local2, PMPF)
                                If (^K802.MEMW)
                                {
                                    Divide (0x07D0, BBBB, Local2, CLTF)
                                }
                                Else
                                {
                                    Divide (0x0FA0, BBBB, Local2, CLTF)
                                }
                                Store (0xFFFF, BF1A)
                                Store (GLDT (), Local3)
                                Store (GLDW (), Local1)
                                Store (GTBW (Local1, Local3), ATBW)
                                Store (GLBW (Local1, Local3), LBWF)
                                Concatenate (Local5, BU2D, Local4)
                                Return (Local5)
                            }
                            Else
                            {
                                Store (^K803.PM1C, Local2)
                                If (LGreaterEqual (Local2, 0x04))
                                {
                                    Store (0x12AC, Local3)
                                }
                                Else
                                {
                                    If (LEqual (Local2, 0x03))
                                    {
                                        Store (0x0E2E, Local3)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local2, 0x02))
                                        {
                                            Store (0x0C62, Local3)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local2, One))
                                            {
                                                Store (0x0B5E, Local3)
                                            }
                                            Else
                                            {
                                                Store (0x0B2C, Local3)
                                            }
                                        }
                                    }
                                }
                                Add (Local3, 0x01C2, Local3)
                                Add (Local3, 0x1388, Local3)
                                Divide (Local3, 0x64, Local2, BASL)
                                Store (BASL, BF07)
                                Add (Local3, 0x61A8, Local3)
                                Divide (Local3, 0x64, Local2, TAVN)
                                Store (GMCK (), BF08)
                                Store (BU2B, Local4)
                                Store (Zero, Local3)
                                Store (Zero, Local1)
                                While (One)
                                {
                                    If (CSE8 (Local1))
                                    {
                                        Store (One, BF0A)
                                        If (^K802.MEMW)
                                        {
                                            Store (0x02, BF0A)
                                        }
                                        Store (PCS8 (Local1), Local2)
                                        Store (DerefOf (Index (Local2, Zero)), BF0B)
                                        Store (DerefOf (Index (Local2, Zero)), BF0C)
                                        Store (DerefOf (Index (Local2, One)), BF0D)
                                        Store (DerefOf (Index (Local2, One)), BF0E)
                                        If (^K802.MEMW)
                                        {
                                            Multiply (DerefOf (Index (Local2, 0x02)), 0x00200000, BF0F)
                                        }
                                        Else
                                        {
                                            Multiply (DerefOf (Index (Local2, 0x02)), 0x00100000, BF0F)
                                        }
                                        Increment (Local3)
                                        Store (Local4, Local5)
                                        Concatenate (Local5, BU2C, Local4)
                                    }
                                    Increment (Local1)
                                    If (LEqual (Local1, 0x08))
                                    {
                                        Break
                                    }
                                }
                                Store (Local3, BF03)
                                Store (One, BF04)
                                Multiply (0x0F, 0x03E8, Local2)
                                Divide (Local2, 0xA0, , PMPF)
                                If (^K802.MEMW)
                                {
                                    Divide (0x07D0, 0xA0, , CLTF)
                                }
                                Else
                                {
                                    Divide (0x0FA0, 0xA0, , CLTF)
                                }
                                Store (0xFFFF, BF1A)
                                Store (GLDT (), Local3)
                                Store (GLDW (), Local1)
                                Store (ATB8 (Local1, Local3), ATBW)
                                Store (GLBW (Local1, Local3), LBWF)
                                Store (Local4, Local5)
                                Concatenate (Local5, BU2D, Local4)
                                Concatenate (BU2A, Local4, Local5)
                                Return (Local5)
                            }
                        }
                    }
                    Name (HVER, 0x70000112)
                    Name (HCBF, Buffer (One)
                    {
                         0x00
                    })
                    Name (HCTG, Buffer (One)
                    {
                         0x00
                    })
                    Name (DDCA, Buffer (0x80)
                    {
                         0x00
                    })
                    Name (DDCB, Buffer (0x80)
                    {
                         0x00
                    })
                    Name (DGHC, Buffer (0x04)
                    {
                         0x00, 0x00, 0x00, 0x00
                    })
                    Method (DGON, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0xFF))
                        {
                            Store (Zero, Local0)
                            While (One)
                            {
                                Store (DerefOf (Index (DGHC, Local0)), Local1)
                                If (Local1)
                                {
                                    WBYT (Local1, 0xF0, 0xF2)
                                }
                                Sleep (0x0A)
                                Increment (Local0)
                                If (LEqual (Local0, 0x04))
                                {
                                    Break
                                }
                            }
                        }
                        Else
                        {
                            Store (DerefOf (Index (DGHC, Arg0)), Local0)
                            If (Local0)
                            {
                                WBYT (Local0, 0xF0, 0xF2)
                            }
                        }
                        Sleep (0x0190)
                        CLAR ()
                    }
                    Method (DGOF, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0xFF))
                        {
                            Store (Zero, Local0)
                            While (One)
                            {
                                Store (DerefOf (Index (DGHC, Local0)), Local1)
                                If (Local1)
                                {
                                    WBYT (Local1, 0xF0, 0xF0)
                                }
                                Increment (Local0)
                                If (LEqual (Local0, 0x04))
                                {
                                    Break
                                }
                            }
                        }
                        Else
                        {
                            Store (DerefOf (Index (DGHC, Arg0)), Local0)
                            If (Local0)
                            {
                                WBYT (Local0, 0xF0, 0xF0)
                            }
                        }
                        Sleep (0x0190)
                        CLAR ()
                    }
                    Method (HSTA, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (DGHC, Arg0)), Local0)
                        If (Local0)
                        {
                            Store (RBYT (Local0, 0x10), Local1)
                            If (LEqual (And (Local1, 0x12), 0x02))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                        Else
                        {
                            Return (One)
                        }
                    }
                    Method (_DSM, 4, NotSerialized)
                    {
                        If (LEqual (Arg0, Buffer (0x10)
                                {
                                    /* 0000 */   0xA0, 0xA0, 0x95, 0x9D, 0x60, 0x00, 0x48, 0x4D,
                                    /* 0008 */   0xB3, 0x4D, 0x7E, 0x5F, 0xEA, 0x12, 0x9F, 0xD4
                                }))
                        {
                            If (LNotEqual (Arg1, 0x0102))
                            {
                                Return (0x80000002)
                            }
                            Name (TTT0, Zero)
                            Store (Arg2, TTT0)
                            If (LEqual (TTT0, Zero))
                            {
                                Return (0x3F8B)
                            }
                            Else
                            {
                                If (LEqual (TTT0, One))
                                {
                                    If (And (HYCM, One))
                                    {
                                        Return (Buffer (0x04)
                                        {
                                             0x01, 0x00, 0x00, 0x00
                                        })
                                    }
                                    Else
                                    {
                                        Return (Buffer (0x04)
                                        {
                                             0x00, 0x00, 0x00, 0x00
                                        })
                                    }
                                }
                                Else
                                {
                                    If (LEqual (TTT0, 0x02)) {}
                                    Else
                                    {
                                        If (LEqual (TTT0, 0x03))
                                        {
                                            Store (DerefOf (Index (Arg3, One)), Local0)
                                            CreateByteField (Arg3, Zero, PWFC)
                                            If (LEqual (PWFC, One))
                                            {
                                                DGON (Local0)
                                            }
                                            Else
                                            {
                                                If (LEqual (PWFC, 0x02))
                                                {
                                                    DGOF (Local0)
                                                }
                                                Else
                                                {
                                                    Return (HSTA (Local0))
                                                }
                                            }
                                        }
                                        Else
                                        {
                                            If (LEqual (TTT0, 0x04)) {}
                                            Else
                                            {
                                                If (LEqual (TTT0, 0x05)) {}
                                                Else
                                                {
                                                    If (LEqual (TTT0, 0x07))
                                                    {
                                                        Store (0x966A, ^^^SMB0.SMT2)
                                                        Return (Package (0x05)
                                                        {
                                                            0xC6, 
                                                            0xC8, 
                                                            0xCA, 
                                                            0xCC, 
                                                            0xCE
                                                        })
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (TTT0, 0x08))
                                                        {
                                                            CreateByteField (Arg3, Zero, SIND)
                                                            CreateByteField (Arg3, One, SADR)
                                                            Store (SADR, Index (DGHC, SIND))
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (TTT0, 0x09))
                                                            {
                                                                CreateByteField (Arg3, Zero, SLAV)
                                                                CreateByteField (Arg3, One, CMND)
                                                                Return (RBYT (SLAV, CMND))
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (TTT0, 0x0A))
                                                                {
                                                                    CreateByteField (Arg3, Zero, SLAW)
                                                                    CreateByteField (Arg3, One, CMNW)
                                                                    SRBY (SLAW, CMNW)
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (TTT0, 0x0B))
                                                                    {
                                                                        If (Not (Arg3))
                                                                        {
                                                                            Return (HCBF)
                                                                        }
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (TTT0, 0x0C))
                                                                        {
                                                                            CreateByteField (Arg3, Zero, SLAX)
                                                                            CreateByteField (Arg3, One, NDDC)
                                                                            If (LEqual (NDDC, One))
                                                                            {
                                                                                WBYT (SLAX, 0xF0, 0xF4)
                                                                            }
                                                                            Else
                                                                            {
                                                                                WBYT (SLAX, 0xF0, 0xF3)
                                                                            }
                                                                            Store (SMRB (SLAX, 0xF5), Local0)
                                                                            Store (SMRB (SLAX, 0xF6), Local1)
                                                                            Concatenate (Local0, Local1, Local2)
                                                                            Store (SMRB (SLAX, 0xF7), Local0)
                                                                            Concatenate (Local2, Local0, Local1)
                                                                            Store (SMRB (SLAX, 0xF8), Local0)
                                                                            Concatenate (Local1, Local0, Local2)
                                                                            If (LEqual (NDDC, One))
                                                                            {
                                                                                Store (Local2, DDCB)
                                                                            }
                                                                            Else
                                                                            {
                                                                                Store (Local2, DDCA)
                                                                            }
                                                                            Store (SLAX, HCTG)
                                                                            Return (0x03)
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (TTT0, 0x0D))
                                                                            {
                                                                                CreateByteField (Arg3, Zero, SLAY)
                                                                                CreateByteField (Arg3, One, NDDY)
                                                                                If (LEqual (HCTG, SLAY))
                                                                                {
                                                                                    If (LEqual (NDDY, One))
                                                                                    {
                                                                                        Return (DDCB)
                                                                                    }
                                                                                    Else
                                                                                    {
                                                                                        Return (DDCA)
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Return (Zero)
                        }
                        Return (Zero)
                    }
                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x06)
                        {
                            0x0110, 
                            0x80000100, 
                            0x80000210, 
                            0x80007330, 
                            0x80046340, 
                            0x80040320
                        })
                    }
                    Device (CRT0)
                    {
                        Name (_ADR, 0x80000100)
                    }
                    Device (LCD0)
                    {
                        Name (_ADR, 0x0110)
                    }
                    Device (DDVI)
                    {
                        Name (_ADR, 0x80040320)
                    }
                }
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
                Notify (\_SB.PCI0.SMB0, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L0D, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.USB0, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L05, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.USB2, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L18, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.US15, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
            Method (_L17, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.US12, 0x02)
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
                    If (And (CTRL, 0x04))
                    {
                        ^SMB0.GPMD (One)
                        Store (One, ^SMB0.XPME)
                    }
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
}
