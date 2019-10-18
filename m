Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2FDD09F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:50:20 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9028210FCB91F;
	Fri, 18 Oct 2019 13:52:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0046510FCB91D
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:52:21 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 13:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,313,1566889200";
   d="scan'208";a="208985818"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2019 13:50:16 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 18 Oct 2019 13:50:16 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX109.amr.corp.intel.com ([169.254.15.66]) with mapi id 14.03.0439.000;
 Fri, 18 Oct 2019 13:50:15 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 08/10] Documentation: clarify memory movablity for
 reconfigure-device
Thread-Topic: [ndctl PATCH 08/10] Documentation: clarify memory movablity
 for reconfigure-device
Thread-Index: AQHVeXwNJqXMUbYruUm0ajWxHeyxPKdhbLkAgAAA7wA=
Date: Fri, 18 Oct 2019 20:50:14 +0000
Message-ID: <9960b57e259cca31715326bbe8b4da5ec3cae100.camel@intel.com>
References: <20191002234925.9190-1-vishal.l.verma@intel.com>
	 <20191002234925.9190-9-vishal.l.verma@intel.com>
	 <CAPcyv4hHT1fjPirPE8Ex5NZ8_4SjoTj-GNaXP+0+14jNBCHTig@mail.gmail.com>
In-Reply-To: <CAPcyv4hHT1fjPirPE8Ex5NZ8_4SjoTj-GNaXP+0+14jNBCHTig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <3036BA1FBE1F0D4F8FFF0058CAD8EDB3@intel.com>
MIME-Version: 1.0
Message-ID-Hash: QKPP6YJGO2W3PQJF6MRZ6PWN6JKIWZG6
X-Message-ID-Hash: QKPP6YJGO2W3PQJF6MRZ6PWN6JKIWZG6
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Olson, Ben" <ben.olson@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Biesek, Michal" <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QKPP6YJGO2W3PQJF6MRZ6PWN6JKIWZG6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2019-10-18 at 13:46 -0700, Dan Williams wrote:
>
> > +'daxctl-reconfigure-device' nominally expects that it will online new memory
> > +blocks as 'movable', so that kernel data doesn't make it into this memory.
> > +However, there are other potential agents that may be configured to
> > +automatically online new hot-plugged memory as it appears. Most notably,
> > +these are the '/sys/devices/system/memory/auto_online_blocks' configuration,
> > +or system udev rules. If such an agent races to online memory sections, daxctl
> > +checks if the blocks were onlined as 'movable' memory. If this was not the
> > +case, and the memory blocks are found to be in a different zone, then a
> > +warning is displayed. If it is desired that a different agent control the
> > +onlining of memory blocks, and the associated memory zone, then it is
> > +recommended to use the --no-online option described below. This will abridge
> > +the device reconfiguration operation to just hotplugging the memory, and
> > +refrain from then onlining it.
> 
> Oh here's that full description that calls out udev.
> 
> I think just "See daxctl reconfigure-device --help" is sufficient for
> those warnings in the previous patch.

Yep I've truncated the runtime warning down to point here.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
