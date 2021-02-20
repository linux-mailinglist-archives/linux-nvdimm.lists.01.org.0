Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF5432062F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 17:33:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B406100EC1EB;
	Sat, 20 Feb 2021 08:33:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F9D2100EC1E9
	for <linux-nvdimm@lists.01.org>; Sat, 20 Feb 2021 08:33:47 -0800 (PST)
IronPort-SDR: MNQuOhD7x2Y6tFUXXSESBeLkzGqaJzvvVjrqx9sm54+bvpbGu7Abv9pOHxXcTAGcU3KL8nfLtg
 h/AvE4O59Ogw==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="184217006"
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400";
   d="scan'208";a="184217006"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 08:33:46 -0800
IronPort-SDR: HCmfnr4BFvfkIsrMlOz26nZFz60eFrZkpzp+8aso+hjQSnAOdAEixQnxHfrxtY+96fnx6Du/in
 +adw/bEQtbxQ==
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400";
   d="scan'208";a="582068409"
Received: from aevangel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 08:33:46 -0800
Date: Sat, 20 Feb 2021 08:33:44 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v5 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <20210220163344.csczmkyxkpu4fxah@intel.com>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-5-ben.widawsky@intel.com>
 <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
Message-ID-Hash: 3TARRBJR2SXZEZBLJDQ3V7OQQPXJJGYN
X-Message-ID-Hash: 3TARRBJR2SXZEZBLJDQ3V7OQQPXJJGYN
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3TARRBJR2SXZEZBLJDQ3V7OQQPXJJGYN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-19 20:22:00, Konrad Rzeszutek Wilk wrote:
> ..snip..
> > +static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> > +					const struct cxl_mem_command *cmd,
> > +					u64 in_payload, u64 out_payload,
> > +					s32 *size_out, u32 *retval)
> > +{
> > +	struct device *dev = &cxlm->pdev->dev;
> > +	struct mbox_cmd mbox_cmd = {
> > +		.opcode = cmd->opcode,
> > +		.size_in = cmd->info.size_in,
> > +		.size_out = cmd->info.size_out,
> > +	};
> > +	int rc;
> > +
> > +	if (cmd->info.size_out) {
> > +		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> > +		if (!mbox_cmd.payload_out)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	if (cmd->info.size_in) {
> > +		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> > +						   cmd->info.size_in);
> > +		if (IS_ERR(mbox_cmd.payload_in))
> > +			return PTR_ERR(mbox_cmd.payload_in);
> 
> Not that this should happen, but what if info.size_out was set? Should
> you also free mbox_cmd.payload_out?
> 

Thanks Konrad.

Dan, do you want me to send a fixup patch? This bug was introduced from v4->v5.

> > +	}
> > +
> > +	rc = cxl_mem_mbox_get(cxlm);
> > +	if (rc)
> > +		goto out;
> > +
> > +	dev_dbg(dev,
> > +		"Submitting %s command for user\n"
> > +		"\topcode: %x\n"
> > +		"\tsize: %ub\n",
> > +		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
> > +		cmd->info.size_in);
> > +
> > +	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> > +	cxl_mem_mbox_put(cxlm);
> > +	if (rc)
> > +		goto out;
> > +
> > +	/*
> > +	 * @size_out contains the max size that's allowed to be written back out
> > +	 * to userspace. While the payload may have written more output than
> > +	 * this it will have to be ignored.
> > +	 */
> > +	if (mbox_cmd.size_out) {
> > +		dev_WARN_ONCE(dev, mbox_cmd.size_out > *size_out,
> > +			      "Invalid return size\n");
> > +		if (copy_to_user(u64_to_user_ptr(out_payload),
> > +				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
> > +			rc = -EFAULT;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	*size_out = mbox_cmd.size_out;
> > +	*retval = mbox_cmd.return_code;
> > +
> > +out:
> > +	kvfree(mbox_cmd.payload_in);
> > +	kvfree(mbox_cmd.payload_out);
> > +	return rc;
> > +}
> 
> ..snip..
> 
> > +static int cxl_query_cmd(struct cxl_memdev *cxlmd,
> > +			 struct cxl_mem_query_commands __user *q)
> > +{
> > +	struct device *dev = &cxlmd->dev;
> > +	struct cxl_mem_command *cmd;
> > +	u32 n_commands;
> > +	int j = 0;
> 
> How come it is 'j' instead of the usual 'i'?

Just how it got split out/copied from an earlier version of the series.

I think rename to i, or cmds would be best as well. I/Dan can do it as part of
the bug fix you found above.

> > +
> > +	dev_dbg(dev, "Query IOCTL\n");
> > +
> > +	if (get_user(n_commands, &q->n_commands))
> > +		return -EFAULT;
> > +
> > +	/* returns the total number if 0 elements are requested. */
> > +	if (n_commands == 0)
> > +		return put_user(cxl_cmd_count, &q->n_commands);
> > +
> > +	/*
> > +	 * otherwise, return max(n_commands, total commands) cxl_command_info
> > +	 * structures.
> > +	 */
> > +	cxl_for_each_cmd(cmd) {
> > +		const struct cxl_command_info *info = &cmd->info;
> > +
> > +		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > +			return -EFAULT;
> > +
> > +		if (j == n_commands)
> > +			break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
