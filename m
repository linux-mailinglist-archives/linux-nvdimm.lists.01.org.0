Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E87B1C16C0
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 16:09:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3DA871141F796;
	Fri,  1 May 2020 07:08:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 937C51141F794
	for <linux-nvdimm@lists.01.org>; Fri,  1 May 2020 07:08:04 -0700 (PDT)
IronPort-SDR: GKsyDvPPWtu+VrR40h4KQzLFY+0JoNPaWqDE7fz8KISCZd+yvP4WFiOyxzpoMe9dBZUXgxdG4J
 21RYh4rgrsjg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 07:09:21 -0700
IronPort-SDR: T8F0QqIQVBxO8n19+0hE/vGhvzYePOPeBHTI9gbaOnHqLw9nF12kUm+ibLM91YufzG0lEtO7Jh
 TDHwScBUPBRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400";
   d="scan'208";a="460272134"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga006.fm.intel.com with ESMTP; 01 May 2020 07:09:21 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 1 May 2020 07:09:20 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.187]) with mapi id 14.03.0439.000;
 Fri, 1 May 2020 07:09:20 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@amacapital.net>, Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: RE: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Thread-Topic: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Thread-Index: AQHWHsst2+7frPAw9kCYaqQsGNEgp6iSJ9mAgAAvKwCAAAcmgIAAF8EA//+WBACAAH0TAIAAQ4gAgAAE/4CAAAO1gIAAb4YQ
Date: Fri, 1 May 2020 14:09:20 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net>
In-Reply-To: <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Message-ID-Hash: EL6VP5RULRRCZDVM7KUSHQCJJTOILHHQ
X-Message-ID-Hash: EL6VP5RULRRCZDVM7KUSHQCJJTOILHHQ
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Tsaur, Erwin" <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EL6VP5RULRRCZDVM7KUSHQCJJTOILHHQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

PiBOb3cgbWF5YmUgY29weV90b191c2VyKCkgc2hvdWxkICphbHdheXMqIHdvcmsgdGhpcyB3YXks
IGJ1dCBJ4oCZbSBub3QgY29udmluY2VkLg0KPiBDZXJ0YWlubHkgcHV0X3VzZXIoKSBzaG91bGRu
4oCZdCDigJQgdGhlIHJlc3VsdCB3b3VsZG7igJl0IGV2ZW4gYmUgd2VsbCBkZWZpbmVkLiBBbmQg
SeKAmW0NCj4gIHVuY29udmluY2VkIHRoYXQgaXQgbWFrZXMgbXVjaCBzZW5zZSBmb3IgdGhlIG1h
am9yaXR5IG9mIGNvcHlfdG9fdXNlcigpIGNhbGxlcnMNCj4gIHRoYXQgYXJlIGFsc28gZGlyZWN0
bHkgYWNjZXNzaW5nIHRoZSBzb3VyY2Ugc3RydWN0dXJlLg0KDQpPbmUgY2FzZSB0aGF0IG1pZ2h0
IHdvcmsgaXMgY29weV90b191c2VyKCkgdGhhdCdzIGNvcHlpbmcgZnJvbSB0aGUga2VybmVsIHBh
Z2UgY2FjaGUNCnRvIHRoZSB1c2VyIGluIHJlc3BvbnNlIHRvIGEgcmVhZCgyKSBzeXN0ZW0gY2Fs
bC4gIEFjdGlvbiB3b3VsZCBiZSB0byBjaGVjayBpZiB3ZSBjb3VsZA0KcmUtcmVhZCBmcm9tIHRo
ZSBmaWxlIHN5c3RlbSB0byBhIGRpZmZlcmVudCBwYWdlLiBJZiBub3QsIHJldHVybiAtRUlPLiBF
aXRoZXIgd2F5IGRpdGNoIHRoZQ0KcG9pc29uIHBhZ2UgZnJvbSB0aGUgcGFnZSBjYWNoZS4NCg0K
LVRvbnkNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1
bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5v
cmcK
