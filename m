Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 251DE314719
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 04:36:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7967A100EB33B;
	Mon,  8 Feb 2021 19:36:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED5EF100EB853
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 19:36:29 -0800 (PST)
IronPort-SDR: MAvvjucihPKV8FNyrVQYPiPChcqHms4INqgd4CJmE6rRZCJf3sOuyl9evbVKl6Yb62VWgdwCMe
 2DRlKpr4qiGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181886022"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400";
   d="scan'208";a="181886022"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 19:36:29 -0800
IronPort-SDR: LN03VMDKQ/0sU1LGOQIASxmpP5Dpd6LL7QAsWNf8MtjRaqoKRyx5g591ArznAjEoE1NurvivIm
 LXXEAQG60rFw==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400";
   d="scan'208";a="435915502"
Received: from ashishs1-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.132.35])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 19:36:28 -0800
Date: Mon, 8 Feb 2021 19:36:27 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
Message-ID: <20210209033611.dgty2z2z4ds7p2td@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com>
 <CAPcyv4iPXqO5FL4_bmMQaSvmUm9FVrPv9yPJr3Q4DQWYf4t5hQ@mail.gmail.com>
 <202102081406.CDE33FB8@keescook>
 <CAPcyv4ix=zmQdb5sFKN-9wOZFnitHN0sSwHZJgQeaEM+=6+W1w@mail.gmail.com>
 <CAPcyv4hFLnY4b8a7z+rWVeayHka4BLZyXse_ExSeRWuBRxjCwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hFLnY4b8a7z+rWVeayHka4BLZyXse_ExSeRWuBRxjCwA@mail.gmail.com>
Message-ID-Hash: OBZXMQ3OTFEVXETCQXQNBTJ3ASMNWQ7T
X-Message-ID-Hash: OBZXMQ3OTFEVXETCQXQNBTJ3ASMNWQ7T
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OBZXMQ3OTFEVXETCQXQNBTJ3ASMNWQ7T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-08 17:03:25, Dan Williams wrote:
> On Mon, Feb 8, 2021 at 3:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Feb 8, 2021 at 2:09 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Feb 08, 2021 at 02:00:33PM -0800, Dan Williams wrote:
> > > > [ add Jon Corbet as I'd expect him to be Cc'd on anything that
> > > > generically touches Documentation/ like this, and add Kees as the last
> > > > person who added a taint (tag you're it) ]
> > > >
> > > > Jon, Kees, are either of you willing to ack this concept?
> > > >
> > > > Top-posting to add more context for the below:
> > > >
> > > > This taint is proposed because it has implications for
> > > > CONFIG_LOCK_DOWN_KERNEL among other things. These CXL devices
> > > > implement memory like DDR would, but unlike DDR there are
> > > > administrative / configuration commands that demand kernel
> > > > coordination before they can be sent. The posture taken with this
> > > > taint is "guilty until proven innocent" for commands that have yet to
> > > > be explicitly allowed by the driver. This is different than NVME for
> > > > example where an errant vendor-defined command could destroy data on
> > > > the device, but there is no wider threat to system integrity. The
> > > > taint allows a pressure release valve for any and all commands to be
> > > > sent, but flagged with WARN_TAINT_ONCE if the driver has not
> > > > explicitly enabled it on an allowed list of known-good / kernel
> > > > coordinated commands.
> > > >
> > > > On Fri, Jan 29, 2021 at 4:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > For drivers that moderate access to the underlying hardware it is
> > > > > sometimes desirable to allow userspace to bypass restrictions. Once
> > > > > userspace has done this, the driver can no longer guarantee the sanctity
> > > > > of either the OS or the hardware. When in this state, it is helpful for
> > > > > kernel developers to be made aware (via this taint flag) of this fact
> > > > > for subsequent bug reports.
> > > > >
> > > > > Example usage:
> > > > > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > > > > - The xyzzy driver provides an interface for using waldo, but not fred.
> > > > > - quux is convinced they really need the fred command.
> > > > > - xyzzy driver allows quux to frob hardware to initiate fred.
> > > > >   - kernel gets tainted.
> > > > > - turns out fred command is borked, and scribbles over memory.
> > > > > - developers laugh while closing quux's subsequent bug report.
> > >
> > > But a taint flag only lasts for the current boot. If this is a drive, it
> > > could still be compromised after reboot. It sounds like this taint is
> > > really only for ephemeral things? "vendor shenanigans" is a pretty giant
> > > scope ...
> > >
> >
> > That is true. This is more about preventing an ecosystem / cottage
> > industry of tooling built around bypassing the kernel. So the kernel
> > complains loudly and hopefully prevents vendor tooling from
> > propagating and instead directs that development effort back to the
> > native tooling. However for the rare "I know what I'm doing" cases,
> > this tainted kernel bypass lets some experimentation and debug happen,
> > but the kernel is transparent that when the capability ships in
> > production it needs to be a native implementation.
> >
> > So it's less, "the system integrity is compromised" and more like
> > "you're bypassing the development process that ensures sanity for CXL
> > implementations that may take down a system if implemented
> > incorrectly". For example, NVME reset is a non-invent, CXL reset can
> > be like surprise removing DDR DIMM.
> >
> > Should this be more tightly scoped to CXL? I had hoped to use this in
> > other places in LIBNVDIMM, but I'm ok to lose some generality for the
> > specific concerns that make CXL devices different than other PCI
> > endpoints.
> 
> As I type this out it strikes me that plain WARN already does
> TAINT_WARN and meets the spirit of what is trying to be achieved.
> 
> Appreciate the skeptical eye Kees, we'll drop this one.

So I think this is a good compromise for now. However, the point of this taint
was that it is specifically called out what tainted the kernel. It'd be great to
know when we have a bug report it was this specifically that was the issue.
Rambling further I realize now that taint doesn't tell you which module tainted,
which would be great here. That's actually what I'd like.

End ramble.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
