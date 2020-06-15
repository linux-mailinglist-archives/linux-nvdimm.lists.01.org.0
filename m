Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 298041F9762
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jun 2020 14:56:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B19FA11137ED3;
	Mon, 15 Jun 2020 05:56:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.9.137.197; helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0CF5B11137ED2
	for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 05:56:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f063c0085fbd8d4455f52fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:85fb:d8d4:455f:52fc])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4813F1EC0328;
	Mon, 15 Jun 2020 14:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1592225759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=/AESQdNn9F5DJNAvN7Ekrb2QHr0FUj+XXTKW2C8uMmo=;
	b=Fq/hQ2DMKfbOxaJYqCYfztNBgi5oh0HsOx0x7L8VJ4cvNsn8HLUiHwhWxpSTqc4Eyh2BU2
	xRVbBQPrR+Rm8jodEQy0DsYSC7qHKiSva2/xftRAGym3Xdj+qsY8nQ7855vYkCCA2LEo2n
	0CXcuIWGshqqPcwJ9viqJNhwPGKSnlI=
Date: Mon, 15 Jun 2020 14:55:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v13 2/6] seq_buf: Export seq_buf_printf
Message-ID: <20200615125552.GI14668@zn.tnic>
References: <20200615124407.32596-1-vaibhav@linux.ibm.com>
 <20200615124407.32596-3-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615124407.32596-3-vaibhav@linux.ibm.com>
Message-ID-Hash: FYL5L5E5QLGIHHS3QO3VNR6WVKQLVAJI
X-Message-ID-Hash: FYL5L5E5QLGIHHS3QO3VNR6WVKQLVAJI
X-MailFrom: bp@alien8.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FYL5L5E5QLGIHHS3QO3VNR6WVKQLVAJI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 15, 2020 at 06:14:03PM +0530, Vaibhav Jain wrote:
> 'seq_buf' provides a very useful abstraction for writing to a string
> buffer without needing to worry about it over-flowing. However even
> though the API has been stable for couple of years now its still not
> exported to kernel loadable modules limiting its usage.
> 
> Hence this patch proposes update to 'seq_buf.c' to mark
> seq_buf_printf() which is part of the seq_buf API to be exported to
> kernel loadable GPL modules. This symbol will be used in later parts
> of this patch-set to simplify content creation for a sysfs attribute.
> 
> Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v12..v13:
> * None
> 
> v11..v12:
> * None

Can you please resend your patchset once a week like everyone else and
not flood inboxes with it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
