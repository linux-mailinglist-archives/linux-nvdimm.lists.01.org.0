Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB130FC01
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 19:55:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 00F41100EC1F9;
	Thu,  4 Feb 2021 10:55:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8A9BD100EC1E6
	for <linux-nvdimm@lists.01.org>; Thu,  4 Feb 2021 10:55:44 -0800 (PST)
IronPort-SDR: qdRWR2rSXgFaP90fk+bwvK3WdJMzLhzoeu8aQA0xNsc5DzBbMrGsTWCoT8yRyYfq7VhnQ70j6S
 cwzxM5pdmNUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="177803346"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400";
   d="scan'208";a="177803346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 10:55:43 -0800
IronPort-SDR: 9kuExkt4nlo9ze0QjfV35lBjvzzDxy7AIn6Rd/7Gtw34q0j+7KGDkY/Ai8mQRDq1jem7DKVmTh
 NU1MVdRLFXUQ==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400";
   d="scan'208";a="393322655"
Received: from jguillor-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 10:55:42 -0800
Date: Thu, 4 Feb 2021 10:55:40 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
Message-ID: <20210204185540.oxwurggwd7a37a2o@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com>
 <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com>
 <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
 <20210203171610.2y2x4krijol5dvkk@intel.com>
 <YBroGrVd76p+BF0v@Konrads-MacBook-Pro.local>
 <CAPcyv4hMM9isho5d8wS=5vtP0NxE5KA0HrMp+Bx2PZhPDrrWsg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hMM9isho5d8wS=5vtP0NxE5KA0HrMp+Bx2PZhPDrrWsg@mail.gmail.com>
Message-ID-Hash: 7RWUKQA6G35TUNYKCD6OKNQVQREBMSLM
X-Message-ID-Hash: 7RWUKQA6G35TUNYKCD6OKNQVQREBMSLM
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7RWUKQA6G35TUNYKCD6OKNQVQREBMSLM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-03 12:31:00, Dan Williams wrote:
> On Wed, Feb 3, 2021 at 10:16 AM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> >
> > On Wed, Feb 03, 2021 at 09:16:10AM -0800, Ben Widawsky wrote:
> > > On 21-02-02 15:57:03, Dan Williams wrote:
> > > > On Tue, Feb 2, 2021 at 3:51 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> > > > > > On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > > > > > > The Get Log command returns the actual log entries that are advertised
> > > > > > > via the Get Supported Logs command (0400h). CXL device logs are selected
> > > > > > > by UUID which is part of the CXL spec. Because the driver tries to
> > > > > > > sanitize what is sent to hardware, there becomes a need to restrict the
> > > > > > > types of logs which can be accessed by userspace. For example, the
> > > > > > > vendor specific log might only be consumable by proprietary, or offline
> > > > > > > applications, and therefore a good candidate for userspace.
> > > > > > >
> > > > > > > The current driver infrastructure does allow basic validation for all
> > > > > > > commands, but doesn't inspect any of the payload data. Along with Get
> > > > > > > Log support comes new infrastructure to add a hook for payload
> > > > > > > validation. This infrastructure is used to filter out the CEL UUID,
> > > > > > > which the userspace driver doesn't have business knowing, and taints on
> > > > > > > invalid UUIDs being sent to hardware.
> > > > > >
> > > > > > Perhaps a better option is to reject invalid UUIDs?
> > > > > >
> > > > > > And if you really really want to use invalid UUIDs then:
> > > > > >
> > > > > > 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> > > > > >
> > > > > > 2) Wrap it with lockdown code so that you can't do this at all
> > > > > >    when in LOCKDOWN_INTEGRITY or such?
> > > > > >
> > > > >
> > > > > The commit message needs update btw as CEL is allowed in the latest rev of the
> > > > > patches.
> > > > >
> > > > > We could potentially combine this with the now added (in a branch) CONFIG_RAW
> > > > > config option. Indeed I think that makes sense. Dan, thoughts?
> > > >
> > > > Yeah, unknown UUIDs blocking is the same risk as raw commands as a
> > > > vendor can trigger any behavior they want. A "CONFIG_RAW depends on
> > > > !CONFIG_INTEGRITY" policy sounds reasonable as well.
> > >
> > > What about LOCKDOWN_NONE though? I think we need something runtime for this.
> > >
> > > Can we summarize the CONFIG options here?
> > >
> > > CXL_MEM_INSECURE_DEBUG // no change
> > > CXL_MEM_RAW_COMMANDS // if !security_locked_down(LOCKDOWN_NONE)
> > >
> > > bool cxl_unsafe()
> >
> > Would it be better if this inverted? Aka cxl_safe()..
> > ?
> > > {
> > > #ifndef CXL_MEM_RAW_COMMANDS
> 
> nit use IS_ENABLED() if this function lives in a C file, or provide
> whole alternate static inline versions in a header gated by ifdefs.
> 

I had done this independently since... but agreed.

> > >       return false;
> > > #else
> > >       return !security_locked_down(LOCKDOWN_NONE);
> >
> > :thumbsup:
> >
> > (Naturally this would inverted if this was cxl_safe()).
> >
> >
> > > #endif
> > > }
> > >
> > > ---
> > >
> > > Did I get that right?
> >
> > :nods:
> 
> Looks good which means it's time to bikeshed the naming. I'd call it
> cxl_raw_allowed(). As "safety" isn't the only reason for blocking raw,
> it's also to corral the userspace api. I.e. things like enforcing
> security passphrase material through the Linux keys api.

It actually got pushed into cxl_mem_raw_command_allowed()

static bool cxl_mem_raw_command_allowed(u16 opcode)
{
        int i;

        if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
                return false;

        if (security_locked_down(LOCKDOWN_NONE))
                return false;

        if (raw_allow_all)
                return true;

        if (is_security_command(opcode))
                return false;

        for (i = 0; i < ARRAY_SIZE(disabled_raw_commands); i++)
                if (disabled_raw_commands[i] == opcode)
                        return false;

        return true;
}

That work for you?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
