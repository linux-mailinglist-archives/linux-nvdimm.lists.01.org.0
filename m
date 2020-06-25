Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130F6209786
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jun 2020 02:13:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6599210FCC905;
	Wed, 24 Jun 2020 17:13:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C463810FC666A
	for <linux-nvdimm@lists.01.org>; Wed, 24 Jun 2020 17:13:44 -0700 (PDT)
IronPort-SDR: P4WuimEN36/jSJUK01om/5beVl8Sywb1ThFC0K+KOte/0PSwqZHpU1RwJ/G69zO8CH7GZp9sFr
 GZsAlGjcw0pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="162772270"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800";
   d="scan'208";a="162772270"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 17:13:44 -0700
IronPort-SDR: PVKJm8I8Tp39bdX0zSIhvyqqds0/gehQ+YAgi/8RCik4BpqR2KgCZTav94yyNXjWjh4rcak3Hu
 N49+5WAeC3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800";
   d="scan'208";a="310949548"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga008.jf.intel.com with ESMTP; 24 Jun 2020 17:13:43 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.232]) with mapi id 14.03.0439.000;
 Wed, 24 Jun 2020 17:13:43 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jane Chu <jane.chu@oracle.com>, Matthew Wilcox <willy@infradead.org>
Subject: RE: [RFC] Make the memory failure blast radius more precise
Thread-Topic: [RFC] Make the memory failure blast radius more precise
Thread-Index: AQHWSZtiV1cAPccj5U6oivsn3si7c6jmwT6AgAB5HID//41BAIAAeRuAgAF8eAD//7g8cA==
Date: Thu, 25 Jun 2020 00:13:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F67BB29@ORSMSX115.amr.corp.intel.com>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
 <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org>
 <24367ca1-ecb0-de96-b9e5-f94747838c74@oracle.com>
In-Reply-To: <24367ca1-ecb0-de96-b9e5-f94747838c74@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Message-ID-Hash: GLOPPZ225DMKZHRSO5DNM5Q6SKTSYFDS
X-Message-ID-Hash: GLOPPZ225DMKZHRSO5DNM5Q6SKTSYFDS
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, David Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GLOPPZ225DMKZHRSO5DNM5Q6SKTSYFDS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Both the RFC patch and the above 5-step recovery plan look neat, step 4) 
> is nice to carry forward on icelake when a single instruction to clear
> poison is available.

Jane,

Clearing poison has some challenges.

On persistent memory it probably works (as the DIMM is going to remap that address to a different
part of the media to avoid the bad spot).

On DDR memory you'd need to decide whether the problem was transient, so that a simple
overwrite fixes the problem. Or persistent ... in which case the problem will likely come back
with the right data pattern.  To tell that you may need to run some memory test on the affected
area.

If the error was just in a 4K page, I'd be inclined to copy the good data to a new page and
map that in instead. Throwing away one 4K page isn't likely to be painful.

If it is in a 2M/1G page ... perhaps it is worth the effort and risk of trying to clear the poison
in place to avoid the pain of breaking up a large page.

-Tony
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
