Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A96431B13A
	for <lists+linux-nvdimm@lfdr.de>; Sun, 14 Feb 2021 17:30:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E278E100EC1E9;
	Sun, 14 Feb 2021 08:30:37 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:5300:60:148a::1; helo=zeniv-ca.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN> 
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F912100EF250
	for <linux-nvdimm@lists.01.org>; Sun, 14 Feb 2021 08:30:35 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lBKHh-00DvRy-5S; Sun, 14 Feb 2021 16:30:09 +0000
Date: Sun, 14 Feb 2021 16:30:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <YClQEefYBR+YKBUv@zeniv-ca.linux.org.uk>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210210000259.635748-5-ben.widawsky@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Message-ID-Hash: 3NC5MR4EYDZ4C666XY72FYGVOQI7IBME
X-Message-ID-Hash: 3NC5MR4EYDZ4C666XY72FYGVOQI7IBME
X-MailFrom: viro@ftp.linux.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Dan Williams <dan.j.willams@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3NC5MR4EYDZ4C666XY72FYGVOQI7IBME/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 09, 2021 at 04:02:55PM -0800, Ben Widawsky wrote:

> +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> +					const struct cxl_mem_command *cmd,
> +					u64 in_payload, u64 out_payload,
> +					struct cxl_send_command __user *s)
> +{
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +	struct device *dev = &cxlmd->dev;
> +	struct mbox_cmd mbox_cmd = {
> +		.opcode = cmd->opcode,
> +		.size_in = cmd->info.size_in,
> +	};
> +	s32 user_size_out;
> +	int rc;
> +
> +	if (get_user(user_size_out, &s->out.size))
> +		return -EFAULT;

You have already copied it in.  Never reread stuff from userland - it *can*
change under you.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
