Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8831D3D3
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 02:43:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0269100EB320;
	Tue, 16 Feb 2021 17:43:01 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:5300:60:148a::1; helo=zeniv-ca.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN> 
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AFA5A100EC1D7
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 17:42:59 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lC4pR-00Egds-Ey; Tue, 16 Feb 2021 18:12:05 +0000
Date: Tue, 16 Feb 2021 18:12:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v4 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <YCwK9SblYCh/1lZS@zeniv-ca.linux.org.uk>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
 <20210216014538.268106-5-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210216014538.268106-5-ben.widawsky@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Message-ID-Hash: QAIFY4OW3QRWT53U7EXQ4C76V2N6XD3I
X-Message-ID-Hash: QAIFY4OW3QRWT53U7EXQ4C76V2N6XD3I
X-MailFrom: viro@ftp.linux.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QAIFY4OW3QRWT53U7EXQ4C76V2N6XD3I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 15, 2021 at 05:45:33PM -0800, Ben Widawsky wrote:
> +	if (cmd->info.size_in) {
> +		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
> +		if (!mbox_cmd.payload_in) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +
> +		if (copy_from_user(mbox_cmd.payload_in,
> +				   u64_to_user_ptr(in_payload),
> +				   cmd->info.size_in)) {
> +			rc = -EFAULT;
> +			goto out;
> +		}

Umm...  Do you need to open-code vmemdup_user()?  The only difference is
GFP_KERNEL allocation instead of GFP_USER one, and the latter is arguably
saner here...  Zeroing is definitely pointless - you either overwrite
the entire buffer with copy_from_user(), or you fail and free the damn
thing.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
