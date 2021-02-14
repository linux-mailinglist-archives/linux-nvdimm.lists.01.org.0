Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 491EE31B337
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Feb 2021 00:15:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6D415100EBB90;
	Sun, 14 Feb 2021 15:15:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E6A0100EBB8D
	for <linux-nvdimm@lists.01.org>; Sun, 14 Feb 2021 15:14:58 -0800 (PST)
IronPort-SDR: JEveMEOfKrx4FjsQyf+2ZUuZegkLsvhBTNXgx/kNvXJi01Jzq53TIU3qdBbdSOGVj8/YSGv2Ie
 KC4PfaZRyfOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="182678808"
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400";
   d="scan'208";a="182678808"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 15:14:58 -0800
IronPort-SDR: 5baMiPXAMLOLE+02Ny6pfw3U38wyzJ/BY291r/241pX2vv9fWp+/sWXoW5/e34TDtQzqTVMYnU
 aQ6EekstXsAQ==
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400";
   d="scan'208";a="398810113"
Received: from cbfoster-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 15:14:57 -0800
Date: Sun, 14 Feb 2021 15:14:56 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <20210214231456.xnwitliczv6qwmjv@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
 <YClQEefYBR+YKBUv@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YClQEefYBR+YKBUv@zeniv-ca.linux.org.uk>
Message-ID-Hash: WLHENBVXXAUNGGZ3QDVP4CCOSLJLYC4O
X-Message-ID-Hash: WLHENBVXXAUNGGZ3QDVP4CCOSLJLYC4O
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Dan Williams <dan.j.willams@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WLHENBVXXAUNGGZ3QDVP4CCOSLJLYC4O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-14 16:30:09, Al Viro wrote:
> On Tue, Feb 09, 2021 at 04:02:55PM -0800, Ben Widawsky wrote:
> 
> > +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > +					const struct cxl_mem_command *cmd,
> > +					u64 in_payload, u64 out_payload,
> > +					struct cxl_send_command __user *s)
> > +{
> > +	struct cxl_mem *cxlm = cxlmd->cxlm;
> > +	struct device *dev = &cxlmd->dev;
> > +	struct mbox_cmd mbox_cmd = {
> > +		.opcode = cmd->opcode,
> > +		.size_in = cmd->info.size_in,
> > +	};
> > +	s32 user_size_out;
> > +	int rc;
> > +
> > +	if (get_user(user_size_out, &s->out.size))
> > +		return -EFAULT;
> 
> You have already copied it in.  Never reread stuff from userland - it *can*
> change under you.

As it turns out, this is some leftover logic which doesn't need to exist at all,
and I'm happy to change it. Thanks for reviewing.

I wasn't familiar with this restriction though. For my edification could you
explain how that could happen? Also, is this something that should go in the
kdocs, because I don't see anything about this restriction there.

Thanks.
Ben
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
