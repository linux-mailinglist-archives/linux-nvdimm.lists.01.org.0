Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3B30AF6F
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 19:35:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 517F3100EB32F;
	Mon,  1 Feb 2021 10:35:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B58E100EB32E
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 10:34:58 -0800 (PST)
IronPort-SDR: 94ioy2xUTFKNHWizFZ9yoJsqNQCLiHyTRCo8QGuJps4oXkc/wCLpns+vACGklWQm0DtDbVHidK
 f2IRyg8UCJNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="179955435"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="179955435"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:34:58 -0800
IronPort-SDR: 2nH8t8/c+4stZ/sLd9CRvDKJQVvEtoDO5fWXWNPS17Xeu0Z+5yQgq5tPL/lE+iYxcH8yEzg95U
 mZhVmj6F73ng==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400";
   d="scan'208";a="371650563"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 10:34:57 -0800
Date: Mon, 1 Feb 2021 10:34:55 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
Message-ID: <20210201183455.3dndfwyswwvs2dlm@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com>
 <20210201181845.GJ197521@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201181845.GJ197521@fedora>
Message-ID-Hash: ZP6GKFWWU2XFDOEOLKLDUIRRAV2LHUNF
X-Message-ID-Hash: ZP6GKFWWU2XFDOEOLKLDUIRRAV2LHUNF
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZP6GKFWWU2XFDOEOLKLDUIRRAV2LHUNF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-01 13:18:45, Konrad Rzeszutek Wilk wrote:
> On Fri, Jan 29, 2021 at 04:24:32PM -0800, Ben Widawsky wrote:
> > For drivers that moderate access to the underlying hardware it is
> > sometimes desirable to allow userspace to bypass restrictions. Once
> > userspace has done this, the driver can no longer guarantee the sanctity
> > of either the OS or the hardware. When in this state, it is helpful for
> > kernel developers to be made aware (via this taint flag) of this fact
> > for subsequent bug reports.
> > 
> > Example usage:
> > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > - The xyzzy driver provides an interface for using waldo, but not fred.
> > - quux is convinced they really need the fred command.
> > - xyzzy driver allows quux to frob hardware to initiate fred.
> 
> Would it not be easier to _not_ frob the hardware for fred-operation?
> Aka not implement it or just disallow in the first place?

Yeah. So the idea is you either are in a transient phase of the command and some
future kernel will have real support for fred - or a vendor is being short
sighted and not adding support for fred.

> 
> 
> >   - kernel gets tainted.
> > - turns out fred command is borked, and scribbles over memory.
> > - developers laugh while closing quux's subsequent bug report.
> 
> Yeah good luck with that theory in-the-field. The customer won't
> care about this and will demand a solution for doing fred-operation.
> 
> Just easier to not do fred-operation in the first place,no?

The short answer is, in an ideal world you are correct. See nvdimm as an example
of the real world.

The longer answer. Unless we want to wait until we have all the hardware we're
ever going to see, it's impossible to have a fully baked, and validated
interface. The RAW interface is my admission that I make no guarantees about
being able to provide the perfect interface and giving the power back to the
hardware vendors and their driver writers.

As an example, suppose a vendor shipped a device with their special vendor
opcode. They can enable their customers to use that opcode on any driver
version. That seems pretty powerful and worthwhile to me.

Or a more realistic example, we ship a driver that adds a command which is
totally broken. Customers can utilize the RAW interface until it gets fixed in a
subsequent release which might be quite a ways out.

I'll say the RAW interface isn't an encouraged usage, but it's one that I expect
to be needed, and if it's not we can always try to kill it later. If nobody is
actually using it, nobody will complain, right :D
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
