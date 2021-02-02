Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB530CFA8
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 00:08:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 61B83100EB35C;
	Tue,  2 Feb 2021 15:08:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 29535100EC1CE
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 15:08:45 -0800 (PST)
IronPort-SDR: HHqTPa5UTLl18A9zpI/+U5LlnW3M2V7Ngdt4w5nF8JnKu675ycpQHX22Zz9pygmE8wurFAkR03
 RUykI/KiSMAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="245026011"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="245026011"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:08:32 -0800
IronPort-SDR: uvrOannQqhqlOwrNnhCC1hvrm+4Xaz4XoWFfXifM9FKmsSIw6EhYpJCdn/HNAfJ/c8FF94qDis
 TMF+mDTxUshg==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400";
   d="scan'208";a="391916200"
Received: from aisallax-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.131.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:08:31 -0800
Date: Tue, 2 Feb 2021 15:08:29 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 07/14] cxl/mem: Add send command
Message-ID: <20210202230829.sondt7xrpixpv7vz@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-8-ben.widawsky@intel.com>
 <20210201181535.GI197521@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201181535.GI197521@fedora>
Message-ID-Hash: TMAYZUKDYAPL3DFRI2347VN7HJTJJKK5
X-Message-ID-Hash: TMAYZUKDYAPL3DFRI2347VN7HJTJJKK5
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TMAYZUKDYAPL3DFRI2347VN7HJTJJKK5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-01 13:15:35, Konrad Rzeszutek Wilk wrote:
> > +/**
> > + * struct cxl_send_command - Send a command to a memory device.
> > + * @id: The command to send to the memory device. This must be one of the
> > + *	commands returned by the query command.
> > + * @flags: Flags for the command (input).
> > + * @rsvd: Must be zero.
> > + * @retval: Return value from the memory device (output).
> > + * @size_in: Size of the payload to provide to the device (input).
> > + * @size_out: Size of the payload received from the device (input/output). This
> > + *	      field is filled in by userspace to let the driver know how much
> > + *	      space was allocated for output. It is populated by the driver to
> > + *	      let userspace know how large the output payload actually was.
> > + * @in_payload: Pointer to memory for payload input (little endian order).
> > + * @out_payload: Pointer to memory for payload output (little endian order).
> > + *
> > + * Mechanism for userspace to send a command to the hardware for processing. The
> > + * driver will do basic validation on the command sizes. In some cases even the
> > + * payload may be introspected. Userspace is required to allocate large
> > + * enough buffers for size_out which can be variable length in certain
> > + * situations.
> > + */
> I think (and this would help if you ran `pahole` on this structure) has
> some gaps in it:
> 
> > +struct cxl_send_command {
> > +	__u32 id;
> > +	__u32 flags;
> > +	__u32 rsvd;
> > +	__u32 retval;
> > +
> > +	struct {
> > +		__s32 size_in;
> 
> Here..Maybe just add:
> 
> __u32 rsv_2;
> > +		__u64 in_payload;
> > +	};
> > +
> > +	struct {
> > +		__s32 size_out;
> 
> And here. Maybe just add:
> __u32 rsv_2;
> > +		__u64 out_payload;
> > +	};
> > +};
> 
> Perhaps to prepare for the future where this may need to be expanded, you
> could add a size at the start of the structure, and
> maybe what version of structure it is?
> 
> Maybe for all the new structs you are adding?

Thanks for catching the holes. It broke somewhere in the earlier RFC changes.

I don't think we need to size or version. Reserved fields are good enough near
term future proofing and if we get to a point where the command is woefully
incompetent, I think it'd be time to just make cxl_send_command2.

Generally, I think cxl_send_command is fairly future proof because it's so
simple. As you get more complex, you might need better mechanisms, like deferred
command completion for example. It's unclear to me whether we'll get to that
point though, and if we do, I think a new command is warranted.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
