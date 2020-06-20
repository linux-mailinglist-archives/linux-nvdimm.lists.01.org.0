Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903C202026
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Jun 2020 05:20:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B465510FC61BF;
	Fri, 19 Jun 2020 20:20:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5CE2110FC61BD
	for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 20:20:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w16so12338054ejj.5
        for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 20:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=94LSUpgpezJT6SLOqDIDz64i0yvuDf2H+QwXn2NpEgQ=;
        b=hbdkLausbLsCaNUee0v+LeBh3j/v4zbYtqP398VTOc4KUKht3nQsXKqIL1acDb8V2K
         gVRqbqZgV2B6Pgz+xFXr4QuzYc6xLmzx7MBVlXbTIBn0dj9zpgdLLcZTGDWwBAAyWDyL
         hvcvx9WRRyH7oMCvu3nLxmlBt9oQS0locu47YB1pzwB49FlvjnXQQEhCyz/MzPY+unDz
         VGRbk4IUXctGm3f2lpk9PRhhj8Vm8lw46N0AEqUUJtwSmScWX68CF7CdchVgy8tKICIM
         LL/OgEnXrT5MAWa2R/4oEu0GPeC2qihyYt1t1Iahl2zrruwv8FrH3CqOIgQZsW88yIJY
         eNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=94LSUpgpezJT6SLOqDIDz64i0yvuDf2H+QwXn2NpEgQ=;
        b=UF7GrTH9mMxLS36ke+QjApTcBUkK4La9BMpDlmP+BkthjIHYSoygO6k4YJF60FTWcX
         icuxAByxqoOCfLkZSephX0EzAE2ZI/Xr1DZTJ6j7Jb0/VKdhVot+/WXuxO3JdMRJ+1U8
         e/mNg+ZuBT6388dga5oP7j5mH76P4aSJYSew6yFDBjrv/EjknHR/U1nCY+R35Ln4BiDc
         A0Q+6TxN3EvD3QA6gAm0T4yxSueQyr52bNTUhe1PJgqygdvR4oLuEua1g60VYBjMfzt4
         +BFCQJRRqS7ZXAUwHmmWsDnnSO4AwoZfZlO8ACesUd9K8UA27V2u+tJIr174RpgC62mR
         k+Rw==
X-Gm-Message-State: AOAM53147fLc/pK4GIWWM8QmA1T4eh4/QFdfh4HAiNFy1zmH66EqNaEk
	4bbuwIJaEPTBrU/vKqXCTrIPcwog86YJuoqshKBGsgGgLok=
X-Google-Smtp-Source: ABdhPJzoNjxI5TlQZ4uu3ItqM0AmV7WfjoExcHBOL+TpQyr7bEzbNwDxV+J2p7Ft4ZNag26IQtYsMU08wYADrl3S/FQ=
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr157826ejb.174.1592623211288;
 Fri, 19 Jun 2020 20:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR04MB4310650471DD3C25D77BEA6394980@BYAPR04MB4310.namprd04.prod.outlook.com>
 <CAPcyv4jDgD82S9VHWb-P5iP+UH-gqdsYcNmA=aMFNhKrdSEUqg@mail.gmail.com>
 <BYAPR04MB4310B8A76F318E50237447E294980@BYAPR04MB4310.namprd04.prod.outlook.com>
 <CAPcyv4gLX1p5Amz_9V7SGurX+aTQfmPdTp8DSTm53u2Qgtgj=A@mail.gmail.com> <BYAPR04MB4310B35B8E6A7D66DEB78C0194990@BYAPR04MB4310.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4310B35B8E6A7D66DEB78C0194990@BYAPR04MB4310.namprd04.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Jun 2020 20:20:00 -0700
Message-ID: <CAPcyv4g3dtqL6SUfwVd7L6h-pFM+wgJYAXBBaRLq447zdHrtAQ@mail.gmail.com>
Subject: Re: Question on PMEM regions (Linux 4.9 Kernel & above)
To: "Ananth, Rajesh" <Rajesh.Ananth@smartm.com>
Message-ID-Hash: TEXAMLM4DHGD3DSZ76TBEQA5BCAL4SMZ
X-Message-ID-Hash: TEXAMLM4DHGD3DSZ76TBEQA5BCAL4SMZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TEXAMLM4DHGD3DSZ76TBEQA5BCAL4SMZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 19, 2020 at 7:02 PM Ananth, Rajesh <Rajesh.Ananth@smartm.com> wrote:
>
> We used the Ubuntu 18.04 to get the "acpdump" outputs (This is the only complete package distribution we have. Otherwise, we use mainly the built Kernels).  The NFIT data is all valid, but somehow it is printing the "@ addresss" at the beginning as zeros.
>
> =============================  acpdump -n NFIT  ========================================
>
> NFIT @ 0x0000000000000000              <<<<  DON'T KNOW WHY.

That's fine, acpixtract was still able to convert it... I see this
from disassembling it:

acpixtract -s NFIT nfit.txt
iasl -d nft.dat
cat nfit.dsl


[000h 0000   4]                    Signature : "NFIT"    [NVDIMM
Firmware Interface Table]
[004h 0004   4]                 Table Length : 000001A4
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 83
[00Ah 0010   6]                       Oem ID : "ALASKA"
[010h 0016   8]                 Oem Table ID : "A M I "
[018h 0024   4]                 Oem Revision : 00000002
[01Ch 0028   4]              Asl Compiler ID : "INTL"
[020h 0032   4]        Asl Compiler Revision : 20091013

[024h 0036   4]                     Reserved : 00000000

[028h 0040   2]                Subtable Type : 0000 [System Physical
Address Range]
[02Ah 0042   2]                       Length : 0038

[02Ch 0044   2]                  Range Index : 0001
[02Eh 0046   2]        Flags (decoded below) : 0002
                   Add/Online Operation Only : 0
                      Proximity Domain Valid : 1
[030h 0048   4]                     Reserved : 00000000
[034h 0052   4]             Proximity Domain : 00000000
[038h 0056  16]             Region Type GUID :
66F0D379-B4F3-4074-AC43-0D3318B78CDB
[048h 0072   8]           Address Range Base : 0000004080000000
[050h 0080   8]         Address Range Length : 0000000400000000
[058h 0088   8]         Memory Map Attribute : 0000000000008008
[..]
[0E0h 0224   2]                Subtable Type : 0000 [System Physical
Address Range]
[0E2h 0226   2]                       Length : 0038

[0E4h 0228   2]                  Range Index : 0002
[0E6h 0230   2]        Flags (decoded below) : 0002
                   Add/Online Operation Only : 0
                      Proximity Domain Valid : 1
[0E8h 0232   4]                     Reserved : 00000000
[0ECh 0236   4]             Proximity Domain : 00000000
[0F0h 0240  16]             Region Type GUID :
66F0D379-B4F3-4074-AC43-0D3318B78CDB
[100h 0256   8]           Address Range Base : 0000004480000000
[108h 0264   8]         Address Range Length : 0000000400000000
[110h 0272   8]         Memory Map Attribute : 0000000000008008


...so Linux is being handed an NFIT with 2 regions. So the 4.16
interpretation looks correct to me. Are you sure you only changed
kernel versions and did not also do a BIOS update? If not the 4.7
result looks like a bug for this NFIT.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
