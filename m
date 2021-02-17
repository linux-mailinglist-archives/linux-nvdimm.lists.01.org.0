Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9A131DB48
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 15:18:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7D012100EAAEB;
	Wed, 17 Feb 2021 06:18:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5D47D100EAAEA
	for <linux-nvdimm@lists.01.org>; Wed, 17 Feb 2021 06:18:11 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DgfwT1hRjz67qL6;
	Wed, 17 Feb 2021 22:14:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Feb 2021 15:18:08 +0100
Received: from localhost (10.47.29.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 17 Feb
 2021 14:18:06 +0000
Date: Wed, 17 Feb 2021 14:16:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v5 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <20210217141659.000064ec@Huawei.com>
In-Reply-To: <20210217040958.1354670-5-ben.widawsky@intel.com>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
	<20210217040958.1354670-5-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.29.73]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: TJ5GAAU6J4XDS55JU4UEUFHAYIX2FK7D
X-Message-ID-Hash: TJ5GAAU6J4XDS55JU4UEUFHAYIX2FK7D
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, "Chris Browy  <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>,  Dan Williams  <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, David Rientjes" <rientjes@google.com>, "Jon Masters  <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap" <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, kernel test robot <lkp@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TJ5GAAU6J4XDS55JU4UEUFHAYIX2FK7D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 16 Feb 2021 20:09:53 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Add a straightforward IOCTL that provides a mechanism for userspace to
> query the supported memory device commands. CXL commands as they appear
> to userspace are described as part of the UAPI kerneldoc. The command
> list returned via this IOCTL will contain the full set of commands that
> the driver supports, however, some of those commands may not be
> available for use by userspace.
> 
> Memory device commands first appear in the CXL 2.0 specification. They
> are submitted through a mailbox mechanism specified in the CXL 2.0
> specification.
> 
> The send command allows userspace to issue mailbox commands directly to
> the hardware. The list of available commands to send are the output of
> the query command. The driver verifies basic properties of the command
> and possibly inspect the input (or output) payload to determine whether
> or not the command is allowed (or might taint the kernel).
> 
> Reported-by: kernel test robot <lkp@intel.com> # bug in earlier revision
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
