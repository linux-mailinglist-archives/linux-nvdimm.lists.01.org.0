Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217C3316FBF
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 20:12:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 550B3100EA91A;
	Wed, 10 Feb 2021 11:12:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 35400100EB831
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 11:12:32 -0800 (PST)
IronPort-SDR: ns/YRBAc0DN1g/IJDe5ZOOB0bnn7MEicP2/7oQqS14hzRQIf2tC177Lebj1DgRSnUTLua/58WV
 jA7J2zITrXTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="201252352"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400";
   d="scan'208";a="201252352"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 11:12:31 -0800
IronPort-SDR: Fie5eJeuLNs0eRaUUcCs4YlA4FQebSj8KQrBRdj2C+VE36PAJ0mwNut9ixx6yhKDF28tv6lc4w
 3hW+HalhASpQ==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400";
   d="scan'208";a="362255467"
Received: from lgrunes-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 11:12:30 -0800
Date: Wed, 10 Feb 2021 11:12:29 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Ariel.Sibley@microchip.com
Subject: Re: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
Message-ID: <20210210191229.xgsr4s27iveo37qv@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-6-ben.widawsky@intel.com>
 <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <20210210164904.lfhtfvlyeypfpjhe@intel.com>
 <MN2PR11MB36450EFC1729D9A4CDB2FB27888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <20210210181159.opwjsjovzsom7rky@intel.com>
 <MN2PR11MB364513777E713224B3BB7D74888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR11MB364513777E713224B3BB7D74888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
Message-ID-Hash: V5G3ZIBMUMOFRRKQM3T6AQJ2TYHQP2CR
X-Message-ID-Hash: V5G3ZIBMUMOFRRKQM3T6AQJ2TYHQP2CR
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, helgaas@kernel.org, cbrowy@avery-design.com, hch@infradead.org, david@redhat.com, rientjes@google.com, jcm@jonmasters.org, Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com, rdunlap@infradead.org, jgroves@micron.com, sean.v.kelley@intel.com, Ahmad.Danesh@microchip.com, Varada.Dighe@microchip.com, Kirthi.Shenoy@microchip.com, Sanjay.Goyal@microchip.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V5G3ZIBMUMOFRRKQM3T6AQJ2TYHQP2CR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-10 18:46:04, Ariel.Sibley@microchip.com wrote:
> > > > > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > > > > index c4ba3aa0a05d..08eaa8e52083 100644
> > > > > > --- a/drivers/cxl/Kconfig
> > > > > > +++ b/drivers/cxl/Kconfig
> > > > > > @@ -33,6 +33,24 @@ config CXL_MEM
> > > > > >
> > > > > >           If unsure say 'm'.
> > > > > >
> > > > > > +config CXL_MEM_RAW_COMMANDS
> > > > > > +       bool "RAW Command Interface for Memory Devices"
> > > > > > +       depends on CXL_MEM
> > > > > > +       help
> > > > > > +         Enable CXL RAW command interface.
> > > > > > +
> > > > > > +         The CXL driver ioctl interface may assign a kernel ioctl command
> > > > > > +         number for each specification defined opcode. At any given point in
> > > > > > +         time the number of opcodes that the specification defines and a device
> > > > > > +         may implement may exceed the kernel's set of associated ioctl function
> > > > > > +         numbers. The mismatch is either by omission, specification is too new,
> > > > > > +         or by design. When prototyping new hardware, or developing /
> > > > > > debugging
> > > > > > +         the driver it is useful to be able to submit any possible command to
> > > > > > +         the hardware, even commands that may crash the kernel due to their
> > > > > > +         potential impact to memory currently in use by the kernel.
> > > > > > +
> > > > > > +         If developing CXL hardware or the driver say Y, otherwise say N.
> > > > >
> > > > > Blocking RAW commands by default will prevent vendors from developing user
> > > > > space tools that utilize vendor specific commands. Vendors of CXL.mem devices
> > > > > should take ownership of ensuring any vendor defined commands that could cause
> > > > > user data to be exposed or corrupted are disabled at the device level for
> > > > > shipping configurations.
> > > >
> > > > Thanks for brining this up Ariel. If there is a recommendation on how to codify
> > > > this, I would certainly like to know because the explanation will be long.
> > > >
> > > > ---
> > > >
> > > > The background:
> > > >
> > > > The enabling/disabling of the Kconfig option is driven by the distribution
> > > > and/or system integrator. Even if we made the default 'y', nothing stops them
> > > > from changing that. if you are using this driver in production and insist on
> > > > using RAW commands, you are free to carry around a small patch to get rid of the
> > > > WARN (it is a one-liner).
> > > >
> > > > To recap why this is in place - the driver owns the sanctity of the device and
> > > > therefore a [large] part of the whole system. What we can do as driver writers
> > > > is figure out the set of commands that are "safe" and allow those. Aside from
> > > > being able to validate them, we're able to mediate them with other parallel
> > > > operations that might conflict. We gain the ability to squint extra hard at bug
> > > > reports. We provide a reason to try to use a well defined part of the spec.
> > > > Realizing that only allowing that small set of commands in a rapidly growing
> > > > ecosystem is not a welcoming API; we decided on RAW.
> > > >
> > > > Vendor commands can be one of two types:
> > > > 1. Some functionality probably most vendors want.
> > > > 2. Functionality that is really single vendor specific.
> > > >
> > > > Hopefully we can agree that the path for case #1 is to work with the consortium
> > > > to standardize a command that does what is needed and that can eventually become
> > > > part of UAPI. The situation is unfortunate, but temporary. If you won't be able
> > > > to upgrade your kernel, patch out the WARN as above.
> > > >
> > > > The second situation is interesting and does need some more thought and
> > > > discussion.
> > > >
> > > > ---
> > > >
> > > > I see 3 realistic options for truly vendor specific commands.
> > > > 1. Tough noogies. Vendors aren't special and they shouldn't do that.
> > > > 2. modparam to disable the WARN for specific devices (let the sysadmin decide)
> > > > 3. Try to make them part of UAPI.
> > > >
> > > > The right answer to me is #1, but I also realize I live in the real world.
> > > >
> > > > #2 provides too much flexibility. Vendors will just do what they please and
> > > > distros and/or integrators will be seen as hostile if they don't accommodate.
> > > >
> > > > I like #3, but I have a feeling not everyone will agree. My proposal for vendor
> > > > specific commands is, if it's clear it's truly a unique command, allow adding it
> > > > as part of UAPI (moving it out of RAW). I expect like 5 of these, ever. If we
> > > > start getting multiple per vendor, we've failed. The infrastructure is already
> > > > in place to allow doing this pretty easily. I think we'd have to draw up some
> > > > guidelines (like adding test cases for the command) to allow these to come in.
> > > > Anything with command effects is going to need extra scrutiny.
> > >
> > > This would necessitate adding specific opcode values in the range C000h-FFFFh
> > > to UAPI, and those would then be allowed for all CXL.mem devices, correct?  If
> > > so, I do not think this is the right approach, as opcodes in this range are by
> > > definition vendor defined.  A given opcode value will have totally different
> > > effects depending on the vendor.
> > 
> > Perhaps I didn't explain well enough. The UAPI would define the command ID to
> > opcode mapping, for example 0xC000. There would be a validation step in the
> > driver where it determines if it's actually the correct hardware to execute on.
> > So it would be entirely possible to have multiple vendor commands with the same
> > opcode.
> > 
> > So UAPI might be this:
> >         ___C(GET_HEALTH_INFO, "Get Health Info"),                         \
> >         ___C(GET_LOG, "Get Log"),                                         \
> >         ___C(VENDOR_FOO_XXX, "FOO"),                                      \
> >         ___C(VENDOR_BAR_XXX, "BAR"),                                      \
> > 
> > User space just picks the command they want, FOO/BAR. If they use VENDOR_BAR_XXX
> > on VENDOR_FOO's hardware, they will get an error return value.
> 
> Would the driver be doing this enforcement of vendor ID / opcode
> compatibility, or would the error return value mentioned here be from the
> device?  My concern is where the same opcode has two meanings for different
> vendors.  For example, for Vendor A opcode 0xC000 might report some form of
> status information, but for Vendor B it might have data side effects.  There
> may not have been any UAPI intention to expose 0xC000 for Vendor B devices,
> but the existence of 0xC000 in UAPI for Vendor A results in the data
> corrupting version of 0xC000 for Vendor B being allowed.  It would seem to me
> that even if the commands are in UAPI, the driver would still need to rely on
> the contents of the CEL to determine if the command should be allowed.

I think I might not be properly understanding your concern. There are two types
of errors in UAPI that represent 3 error conditions:

1. errno from the ioctl - parameter invalid kind of stuff, this would include using
   the vendor A UAPI on vendor B's device (assuming matching opcodes).
2. errno from the ioctl - transport error of some sort in the mailbox command -
   timeout on doorbell kind of thing.
3. cxl_send_command.retval - Device's error code.

Did that address your concern?

>  
> > > I think you may be on to something with the command effects.  But rather than
> > > "extra scrutiny" for opcodes that have command effects, would it make sense to
> > > allow vendor defined opcodes that have Bit[5:0] in the Command Effect field of
> > > the CEL Entry Structure (Table 173) set to 0?  In conjunction, those bits
> > > represent any change to the configuration or data within the device.  For
> > > commands that have no such effects, is there harm to allowing them?  Of
> > > course, this approach relies on the vendor to not misrepresent the command
> > > effects.
> > >
> > 
> > That last sentence is what worries me :-)
> 
> One must also rely on the vendor to not simply corrupt data at random. :) IMO
> the contents of the CEL should be believed by the driver, rather than the
> driver treating the device as a hostile actor.
> 

I respect your opinion, but my opinion is that driver writers absolutely cannot
rely on that. It would further the conversation a great deal to get concrete
examples of commands that couldn't be part of the core spec and had no effects.
I assume all vendors are going to avoid doing that, which is a real shame.

So far I haven't seen the consortium shoot something down from a vendor because
it is too vendor specific...

> > 
> > 
> > > >
> > > > In my opinion, as maintainers of the driver, we do owe the community an answer
> > > > as to our direction for this. Dan, what is your thought?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
