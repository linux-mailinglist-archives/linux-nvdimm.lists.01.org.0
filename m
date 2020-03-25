Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E91926E1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Mar 2020 12:10:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE5DD10FC36EA;
	Wed, 25 Mar 2020 04:11:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=will@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 34B3710FC36E7
	for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 04:11:36 -0700 (PDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 6B8A320714;
	Wed, 25 Mar 2020 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585134645;
	bh=+oORi421RJ9kNbff15hBXNngbNzPdLiPd7dkY8ZfVx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyTvEz1HkRScEIks3fLO6NxSaEHP3bTnF7g8lw6/Sw86AIEcst4Vj/SPWtZuK/NmF
	 k0ZGmVK6WItq5DMMpc4X2IZd9Mq49bJLWf0Xffqqi6SYMw1UYEfFYhdKwRRgO6bl8X
	 /zcT5VGeyoe/A3wFwuVze9CnAzNQ3nI/5MVCmnjU=
Date: Wed, 25 Mar 2020 11:10:40 +0000
From: Will Deacon <will@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 6/6] ACPI: HMAT: Attach a device for each
 soft-reserved range
Message-ID: <20200325111039.GA32109@willie-the-truck>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: OYKIRK3BX5SZYY5PJFPV4EG6YYDATTDU
X-Message-ID-Hash: OYKIRK3BX5SZYY5PJFPV4EG6YYDATTDU
X-MailFrom: will@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-acpi@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Brice Goglin <Brice.Goglin@inria.fr>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OYKIRK3BX5SZYY5PJFPV4EG6YYDATTDU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 22, 2020 at 09:12:58AM -0700, Dan Williams wrote:
> The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
> "soft reserved" memory as an "hmem" device")' only registered ranges to
> the hmem driver for each soft-reservation that also appeared in the
> HMAT. While this is meant to encourage platform firmware to "do the
> right thing" and publish an HMAT, the corollary is that platforms that
> fail to publish an accurate HMAT will strand memory from Linux usage.
> Additionally, the "efi_fake_mem" kernel command line option enabling
> will strand memory by default without an HMAT.
> 
> Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
> to be published as raw resource ranges for the hmem driver to consume.
> 
> Include a module parameter to disable either this fallback behavior, or
> the hmat enabling from creating hmem devices. The module parameter
> requires the hmem device enabling to have unique name in the module
> namespace: "device_hmem".
> 
> Rather than mark this x86-only, include an interim phys_to_target_node()
> implementation for arm64.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/arm64/mm/numa.c      |   13 +++++++++++++
>  drivers/dax/Kconfig       |    1 +
>  drivers/dax/hmem/Makefile |    3 ++-
>  drivers/dax/hmem/device.c |   33 +++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 4decf1659700..00fba21eaec0 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -468,3 +468,16 @@ int memory_add_physaddr_to_nid(u64 addr)
>  	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
>  	return 0;
>  }
> +
> +/*
> + * device-dax instance registrations want a valid target-node in case
> + * they are ever onlined as memory (see hmem_register_device()).
> + *
> + * TODO: consult cached numa info
> + */
> +int phys_to_target_node(phys_addr_t addr)
> +{
> +	pr_warn_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> +			addr);
> +	return 0;
> +}

Could you implement a generic version of this by iterating over the nodes
with for_each_{,online_}node() and checking for intersection with
node_{start,end}_pfn()?

Will
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
