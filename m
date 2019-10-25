Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3931EE56BB
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 00:56:46 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5ECC4100EA600;
	Fri, 25 Oct 2019 15:57:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7B815100EEBBA
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 15:57:53 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 15:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400";
   d="scan'208";a="192681144"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 25 Oct 2019 15:56:41 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.173]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 15:56:41 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Phillips, D Scott"
	<d.scott.phillips@intel.com>
Subject: Re: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Thread-Topic: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Thread-Index: AQHVi11zx/Vg7UPM5E6mX4rKODcEtqdsam+AgAADGwA=
Date: Fri, 25 Oct 2019 22:56:40 +0000
Message-ID: <38f7f4852ad1cc76c7c7473a6fda85cb9acae14c.camel@intel.com>
References: <20191025175553.63271-1-d.scott.phillips@intel.com>
	 <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
In-Reply-To: <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <DF2368668D1A8B41AFDAAD42333BA373@intel.com>
MIME-Version: 1.0
Message-ID-Hash: Y77WPHB4FUHUNUXA3PLVHLYJGEDBJMV5
X-Message-ID-Hash: Y77WPHB4FUHUNUXA3PLVHLYJGEDBJMV5
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y77WPHB4FUHUNUXA3PLVHLYJGEDBJMV5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 2019-10-25 at 15:45 -0700, Dan Williams wrote:
> On Fri, Oct 25, 2019 at 10:55 AM D Scott Phillips
> <d.scott.phillips@intel.com> wrote:
> > Allow ndctl.h to be licensed with BSD-2-Clause so that other
> > operating systems can provide the same user level interface.
> > ---
> > 
> > I've been working on nvdimm support in FreeBSD and would like to
> > offer the same ndctl API there to ease porting of application
> > code. Here I'm proposing to add the BSD-2-Clause license to this
> > header file, so that it can later be copied into FreeBSD.
> > 
> > I believe that all the authors of changes to this file (in the To:
> > list) would need to agree to this change before it could be
> > accepted, so any signed-off-by is intentionally ommited for now.
> > Thanks,
> 
> I have no problem with this change, but let's take the opportunity to
> let SPDX do its job and drop the full license text.

This is fine by me too, barring the full license text vs. SPDX caveat
Dan mentions.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
