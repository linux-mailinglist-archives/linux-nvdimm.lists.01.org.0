Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65301B17AC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 22:57:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F834100A028D;
	Mon, 20 Apr 2020 13:57:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 33807100A028C
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:57:36 -0700 (PDT)
IronPort-SDR: drC6tR7akAb4q6GcCVmfL/WG4sQyzPwv6+mvPWPD10Mx54IXu5sLGjUH/Jl2WMrWHBpSQwcJBf
 weNOHVZKtrqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 13:57:41 -0700
IronPort-SDR: DhvBja67gLWH7lzxf+Z8l6BP2md94mzZEQGAv7UJxq6pY8rLhkGBVtH/LmfYw8kS/afmt5KOfg
 cviA3NS2knAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200";
   d="scan'208";a="279376609"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2020 13:57:38 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 13:57:37 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.70]) with mapi id 14.03.0439.000;
 Mon, 20 Apr 2020 13:57:37 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, "Williams, Dan J"
	<dan.j.williams@intel.com>
Subject: RE: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
Thread-Topic: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
Thread-Index: AQHWFcAkxzMCKIhw+kKWzhMhw9bMXah/0FOAgAIc84CAAM7CAIAADmyAgAAMx4CAAAaOAIAACpqAgAAE7YCAAAYDAP//jKeQ
Date: Mon, 20 Apr 2020 20:57:37 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5FB29E@ORSMSX115.amr.corp.intel.com>
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com>
 <CAPcyv4hKcAvQEo+peg3MRT3j+u8UdOHVNUWCZhi0aHaiLbe8gw@mail.gmail.com>
 <CAHk-=wj0yVRjD9KgsnOD39k7FzPqhG794reYT4J7HsL0P89oQg@mail.gmail.com>
In-Reply-To: <CAHk-=wj0yVRjD9KgsnOD39k7FzPqhG794reYT4J7HsL0P89oQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Message-ID-Hash: 5776WO4NQXQYY7SSRGFCGW75OBGUELKG
X-Message-ID-Hash: 5776WO4NQXQYY7SSRGFCGW75OBGUELKG
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Tsaur, Erwin" <erwin.tsaur@intel.com>, "Linux Kernel Mailing List  <linux-kernel@vger.kernel.org>, linux-nvdimm" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5776WO4NQXQYY7SSRGFCGW75OBGUELKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>  (a) is a trap, not an exception - so the instruction has been done,
> and you don't need to try to emulate it or anything to continue.

Maybe for errors on the data side of the pipeline. On the instruction
side we can usually recover from user space instruction fetches by
just throwing away the page with the corrupted instructions and reading
from disk into a new page. Then just point the page table to the new
page, and hey presto, its all transparently fixed (modulo time lost fixing
things).

-Tony
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
