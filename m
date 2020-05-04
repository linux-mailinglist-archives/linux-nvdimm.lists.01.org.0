Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C40AE1C47A7
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 22:05:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB1081162A364;
	Mon,  4 May 2020 13:03:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 77DF7116200BC
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 13:03:35 -0700 (PDT)
IronPort-SDR: IolbzFKyzq6qyoDm3I/WtM5gvJLsRLVGBngPV4Q4rGffecldXWwCXlQHcMfEHUbDN1fpXj+BY2
 HS6uLRG+PTlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 13:05:14 -0700
IronPort-SDR: y6fTkTYfYGLd3JKagbsQwauiKg0nMn8mM9txTn416ln2atUAwyG96Uo76gWXw3GTge/+DbTk/6
 +0HZlUW+PY3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,353,1583222400";
   d="scan'208";a="338429331"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2020 13:05:14 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 4 May 2020 13:05:13 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.248]) with mapi id 14.03.0439.000;
 Mon, 4 May 2020 13:05:13 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@amacapital.net>
Subject: RE: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Thread-Topic: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Thread-Index: AQHWHsst2+7frPAw9kCYaqQsGNEgp6iSJ9mAgAAvKwCAAAcmgIAAF8EA//+WBACAAH0TAIAAQ4gAgAAE/4CAAAO1gIAAb4YQgAK28ICAAmL9AA==
Date: Mon, 4 May 2020 20:05:13 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F612DF4@ORSMSX115.amr.corp.intel.com>
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net>
 <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
 <CALCETrW5zNLOrhOS69xeb3ANa0HVAW5+xaHvG2CA8iFy1ByHKQ@mail.gmail.com>
In-Reply-To: <CALCETrW5zNLOrhOS69xeb3ANa0HVAW5+xaHvG2CA8iFy1ByHKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Message-ID-Hash: 5KOB4H26Q7ZCRAPTVEAIJ7UARY2YSK4S
X-Message-ID-Hash: 5KOB4H26Q7ZCRAPTVEAIJ7UARY2YSK4S
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Thomas Gleixner  <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra  <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable" <stable@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>, "H."@ml01.01.org,
	Erwin <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	"Arnaldo Carvalho de Melo  <acme@kernel.org>, linux-nvdimm" <linux-nvdimm@lists.01.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5KOB4H26Q7ZCRAPTVEAIJ7UARY2YSK4S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> When a copy function hits a bad page and the page is not yet known to
> be bad, what does it do?  (I.e. the page was believed to be fine but
> the copy function gets #MC.)  Does it unmap it right away?  What does
> it return?

I suspect that we will only ever find a handful of situations where the
kernel can recover from memory that has gone bad that are worth fixing
(got to be some code path that touches a meaningful fraction of memory,
otherwise we get code complexity without any meaningful payoff).

I don't think we'd want different actions for the cases of "we just found out
now that this page is bad" and "we got a notification an hour ago that this
page had gone bad". Currently we treat those the same for application
errors ... SIGBUS either way[1].

-Tony

[1] well there are options both globally and at the per-process level to have
the "early" notifications delivered right away.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
