Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D830E0B2
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 18:16:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A979E100EAAE1;
	Wed,  3 Feb 2021 09:16:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2504100EAB7E
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 09:16:12 -0800 (PST)
IronPort-SDR: e7jwLkG95wpcWQG2+hWkaSKIYR8u+G3BQgPAjHc5kJjohFL/8MlFyW5e1/xfhUEsW1D5MIqxsA
 tT/E3XirL55A==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="177574072"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400";
   d="scan'208";a="177574072"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:16:12 -0800
IronPort-SDR: kRBAlNWa/d0or8aMCNCiw4lcmGHwaVitVviGAbiEXOCLh21PNebMsCUDBPD4l5Wt+xpTd8MMkB
 kSdrJB4e6+WQ==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400";
   d="scan'208";a="433497230"
Received: from lrenaud-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.246])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:16:11 -0800
Date: Wed, 3 Feb 2021 09:16:10 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
Message-ID: <20210203171610.2y2x4krijol5dvkk@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com>
 <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com>
 <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
Message-ID-Hash: FOYBQTHDRIT54YFUTGHNLZSD7HIZYDLZ
X-Message-ID-Hash: FOYBQTHDRIT54YFUTGHNLZSD7HIZYDLZ
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FOYBQTHDRIT54YFUTGHNLZSD7HIZYDLZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-02 15:57:03, Dan Williams wrote:
> On Tue, Feb 2, 2021 at 3:51 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> > > On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > > > The Get Log command returns the actual log entries that are advertised
> > > > via the Get Supported Logs command (0400h). CXL device logs are selected
> > > > by UUID which is part of the CXL spec. Because the driver tries to
> > > > sanitize what is sent to hardware, there becomes a need to restrict the
> > > > types of logs which can be accessed by userspace. For example, the
> > > > vendor specific log might only be consumable by proprietary, or offline
> > > > applications, and therefore a good candidate for userspace.
> > > >
> > > > The current driver infrastructure does allow basic validation for all
> > > > commands, but doesn't inspect any of the payload data. Along with Get
> > > > Log support comes new infrastructure to add a hook for payload
> > > > validation. This infrastructure is used to filter out the CEL UUID,
> > > > which the userspace driver doesn't have business knowing, and taints on
> > > > invalid UUIDs being sent to hardware.
> > >
> > > Perhaps a better option is to reject invalid UUIDs?
> > >
> > > And if you really really want to use invalid UUIDs then:
> > >
> > > 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> > >
> > > 2) Wrap it with lockdown code so that you can't do this at all
> > >    when in LOCKDOWN_INTEGRITY or such?
> > >
> >
> > The commit message needs update btw as CEL is allowed in the latest rev of the
> > patches.
> >
> > We could potentially combine this with the now added (in a branch) CONFIG_RAW
> > config option. Indeed I think that makes sense. Dan, thoughts?
> 
> Yeah, unknown UUIDs blocking is the same risk as raw commands as a
> vendor can trigger any behavior they want. A "CONFIG_RAW depends on
> !CONFIG_INTEGRITY" policy sounds reasonable as well.

What about LOCKDOWN_NONE though? I think we need something runtime for this.

Can we summarize the CONFIG options here?

CXL_MEM_INSECURE_DEBUG // no change
CXL_MEM_RAW_COMMANDS // if !security_locked_down(LOCKDOWN_NONE)

bool cxl_unsafe()
{
#ifndef CXL_MEM_RAW_COMMANDS
	return false;
#else
	return !security_locked_down(LOCKDOWN_NONE);
#endif
}

---

Did I get that right?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
