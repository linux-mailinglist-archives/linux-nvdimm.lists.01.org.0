Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C733E1B1768
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 22:45:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 12C8B100A0288;
	Mon, 20 Apr 2020 13:45:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4A5910106330
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 13:45:28 -0700 (PDT)
IronPort-SDR: VPMWeWg3KPLILtnAWEFd0beZwx8UY1N/CGuY9gfdxAysEmNcxTR0O+OEuIx3ZocgoH5GE/vIts
 25rVzqOQJBVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 13:45:34 -0700
IronPort-SDR: 9wacpcNj1X7bZVjCS2BWPnrcI9BXhubPhcWdxC9v9tkuthZl31RSKE8EyqAK89B1ixIJ8dk2Od
 vVplzjpcKI9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200";
   d="scan'208";a="279373633"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2020 13:45:34 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.15]) with mapi id 14.03.0439.000;
 Mon, 20 Apr 2020 13:45:33 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
Thread-Topic: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
Thread-Index: AQHWFcAkxzMCKIhw+kKWzhMhw9bMXah/0FOAgAIc84CAAM7CAIAADmyAgAAMx4CAAAaOAIAACpqA//+PPQCAAHZ6AP//jGvw
Date: Mon, 20 Apr 2020 20:45:33 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5FB1C0@ORSMSX115.amr.corp.intel.com>
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com>
 <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
 <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
 <CAHk-=wgOUOveRe8=iFWw0S1LSDEjSfQ-4bM64eiXdGj4n7Omng@mail.gmail.com>
 <20200420202332.GA30160@agluck-desk2.amr.corp.intel.com>
 <CAHk-=whNL-P71xQRsahpYrzKquvz3WwqPCUVPT+1TUmWZ+67TQ@mail.gmail.com>
In-Reply-To: <CAHk-=whNL-P71xQRsahpYrzKquvz3WwqPCUVPT+1TUmWZ+67TQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Message-ID-Hash: UO6PDR22HR2MQAVSIDAIQNKCDJGX3CGF
X-Message-ID-Hash: UO6PDR22HR2MQAVSIDAIQNKCDJGX3CGF
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@amacapital.net>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter@ml01.01.org,
	"Erwin  <erwin.tsaur@intel.com>, Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UO6PDR22HR2MQAVSIDAIQNKCDJGX3CGF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> By "asynchronous" I don't mean "hours later".
>
> Make it be "interrupts are enabled, before serializing instruction".
>
> Yes, we want bounded error handling latency. But that doesn't mean "synchronous"

Another X86 vendor seems to be adding something like that. See MCOMMIT
in https://www.amd.com/system/files/TechDocs/24594.pdf

But I wonder how an OS will know whether it is running some smart
MCOMMIT-aware application that can figure out what to do with bad
data, or a legacy application that should probably be stopped before
it hurts somebody.

I also wonder how expensive MCOMMIT is (since it is essentially
polling for "did any errors happen").

-Tony
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
