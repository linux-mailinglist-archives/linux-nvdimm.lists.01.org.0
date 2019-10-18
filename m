Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D1DCFA6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 21:57:13 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5802310FCB3B2;
	Fri, 18 Oct 2019 12:59:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 564FF10FCB3B0
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 12:59:15 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 12:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200";
   d="scan'208";a="195558049"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 18 Oct 2019 12:57:08 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 18 Oct 2019 12:57:08 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx101.amr.corp.intel.com ([169.254.1.3]) with mapi id 14.03.0439.000;
 Fri, 18 Oct 2019 12:57:08 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 04/10] libdaxctl: add an API to determine if
 memory is movable
Thread-Topic: [ndctl PATCH 04/10] libdaxctl: add an API to determine if
 memory is movable
Thread-Index: AQHVeXwMRByFSAdfLkeOo/W+0xFvyqdhTWMAgAARboA=
Date: Fri, 18 Oct 2019 19:57:07 +0000
Message-ID: <dfd1bdbaa41c3f6e97834d592b32bb10ba562c6a.camel@intel.com>
References: <20191002234925.9190-1-vishal.l.verma@intel.com>
	 <20191002234925.9190-5-vishal.l.verma@intel.com>
	 <CAPcyv4hb7vPbWhb3R5fyJH0H5OqRmhtVr=_D0tiYrkc_r8HpaQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hb7vPbWhb3R5fyJH0H5OqRmhtVr=_D0tiYrkc_r8HpaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <71D88043E3CE0247ABB3216CF87B3641@intel.com>
MIME-Version: 1.0
Message-ID-Hash: XRDAIDTQCSWF2HMDE2Y3Q2JR2TK7MKMG
X-Message-ID-Hash: XRDAIDTQCSWF2HMDE2Y3Q2JR2TK7MKMG
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Olson, Ben" <ben.olson@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Biesek, Michal" <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XRDAIDTQCSWF2HMDE2Y3Q2JR2TK7MKMG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 2019-10-18 at 11:54 -0700, Dan Williams wrote:
> On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > By default, daxctl always attempts to online new memory sections as
> > 'movable' so that routine kernel allocations aren't serviced from this
> > memory, and the memory is later removable via hot-unplug.
> > 
> > System configuration, or other agents (such as udev rules) may race
> > 'daxctl' to online memory, and this may result in the memory not being
> > 'movable'. Add an interface to query the movability of a memory object
> > associated with a dax device.
> > 
> > This is in preparation to both display a 'movable' attribute in device
> > listings, as well as optionally allowing memory to be onlined as
> > non-movable.
> > 
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Reported-by: Ben Olson <ben.olson@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  daxctl/lib/libdaxctl-private.h | 20 +++++++++
> >  daxctl/lib/libdaxctl.c         | 77 ++++++++++++++++++++++++++++++++--
> >  daxctl/lib/libdaxctl.sym       |  5 +++
> >  daxctl/libdaxctl.h             |  1 +
> >  4 files changed, 100 insertions(+), 3 deletions(-)
> > 
> > diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
> > index 7ba3c46..82939bb 100644
> > --- a/daxctl/lib/libdaxctl-private.h
> > +++ b/daxctl/lib/libdaxctl-private.h
> > @@ -44,6 +44,25 @@ enum memory_op {
> >         MEM_SET_ONLINE,
> >         MEM_IS_ONLINE,
> >         MEM_COUNT,
> > +       MEM_FIND_ZONE,
> 
> This is private so the naming is not too big a concern, but isn't this
> a MEM_GET_ZONE? A find operation to me is something that can succeed
> to find nothing, whereas a get operation fail assumes the association
> can always be retrieved barring exceptional conditions.

Hm, my personal view of find vs. get was that 'get' grabs a reference
(or similar) to something which we know how to get to (have a pointer
directly) etc. 'Find' is more of a 'go searching for' something - and it
may involve walking and looping over data structures.

But I'm not too opposed to this, and can change to 'get' if that follows
convention better.


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
