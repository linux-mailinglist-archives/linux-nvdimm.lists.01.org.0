Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF02E406
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 20:04:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71B682128DD43;
	Wed, 29 May 2019 11:04:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2DFBC2128DD37
 for <linux-nvdimm@lists.01.org>; Wed, 29 May 2019 11:04:11 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 May 2019 11:04:09 -0700
X-ExtLoop1: 1
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga006.fm.intel.com with ESMTP; 29 May 2019 11:04:09 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 29 May 2019 11:04:09 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 fmsmsx122.amr.corp.intel.com ([169.254.5.106]) with mapi id 14.03.0415.000;
 Wed, 29 May 2019 11:04:09 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v4 08/10] Documentation/daxctl: add a man page for
 daxctl-reconfigure-device
Thread-Topic: [ndctl PATCH v4 08/10] Documentation/daxctl: add a man page
 for daxctl-reconfigure-device
Thread-Index: AQHVFaQrw2phZDWb2Ey4DO1KZYfULKaC18+AgAAEEwA=
Date: Wed, 29 May 2019 18:04:08 +0000
Message-ID: <6289acafe92b505cc49590bb789a93c51c081f99.camel@intel.com>
References: <20190528222440.30392-1-vishal.l.verma@intel.com>
 <20190528222440.30392-9-vishal.l.verma@intel.com>
 <CAPcyv4iKz-x4oLjW1=TDByfw9_ergexAGNDpPuTwP-88P_v4=A@mail.gmail.com>
In-Reply-To: <CAPcyv4iKz-x4oLjW1=TDByfw9_ergexAGNDpPuTwP-88P_v4=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <D62E7676619A48458C6AF4DF0FCDDEC1@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On Wed, 2019-05-29 at 10:49 -0700, Dan Williams wrote:
> On Tue, May 28, 2019 at 3:24 PM Vishal Verma <vishal.l.verma@intel.com
> > wrote:
> > Add a man page describing the new daxctl-reconfigure-device command.
> > 
> > Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  Documentation/daxctl/Makefile.am              |   3 +-
> >  .../daxctl/daxctl-reconfigure-device.txt      | 118
> > ++++++++++++++++++
> >  2 files changed, 120 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/daxctl/daxctl-reconfigure-
> > device.txt
> [..]
> > +-N::
> > +--no-online::
> > +       By default, memory sections provided by system-ram devices
> > will be
> > +       brought online automatically and immediately. Use this
> > option to
> > +       disable the automatic onlining behavior.
> 
> With a --no-online option it feels like we also need a "daxctl
> online-memory" command to hot-add the memory range associated with the
> given dax device. Otherwise, this looks good to me.

Yes good idea, I'll add a command for that. Would we also then need a
complementary offline-memory command? For someone that might want to
split the offlining step from the mode change? I can't imagine a use
case for it..
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
