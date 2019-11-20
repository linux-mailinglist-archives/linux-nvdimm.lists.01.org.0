Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18749103787
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Nov 2019 11:30:44 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18B28100DC2AE;
	Wed, 20 Nov 2019 02:31:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 54F5C100DC2AD
	for <linux-nvdimm@lists.01.org>; Wed, 20 Nov 2019 02:31:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 47HzVK1tJ2z9sPL;
	Wed, 20 Nov 2019 21:30:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
	s=201909; t=1574245836;
	bh=NoZPjg+0nioBWvif4gw1spRKoX1kFqqPPof1Rda5KVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aLedtDwBTRHLQE3y5ARLngDZMOd0WLJxz56poFpD5/TLbHjLLMPY+g+/dnvleNZ1A
	 7h8lHBaEoVK5BuzEdb8LYbVma1lry1OivSstDcZFDBbZul9eOwM0dA9N/QpRX7T/4u
	 hOW5bb+0IdgBat24zL5Kn9QMuNuuMX3swigIWYmqNbRv/2tevyK0k6I5Il6ozSK5br
	 5t+ExnZxNVFvl+jeYCvtoCYOaC0AW3HZ/oetU9BtOifc7VpDEBqQVYCfQTAKcRdfFk
	 I7281Q60xL/IDK4jdt7pZVMY3Brx0w6eqjliMF7kmPGMlcUyjtrmQWNBPfzlvPsBxE
	 b04DPEpalr6Yw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 16/18] powerpc/papr_scm: Switch to numa_map_to_online_node()
In-Reply-To: <157401276263.43284.12616818803654229788.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401276263.43284.12616818803654229788.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Wed, 20 Nov 2019 21:30:31 +1100
Message-ID: <87lfsac01k.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-ID-Hash: WDNRRW6Z4XSIXUBFQZDOKHOF7X2SH2XI
X-Message-ID-Hash: WDNRRW6Z4XSIXUBFQZDOKHOF7X2SH2XI
X-MailFrom: mpe@ellerman.id.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WDNRRW6Z4XSIXUBFQZDOKHOF7X2SH2XI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:
> Now that the core exports numa_map_to_online_node() switch to that
> instead of the locally coded duplicate.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c |   21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 33aa59e666e5..ef81515f3b6a 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -284,25 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	return 0;
>  }
>  
> -static inline int papr_scm_node(int node)
> -{
> -	int min_dist = INT_MAX, dist;
> -	int nid, min_node;
> -
> -	if ((node == NUMA_NO_NODE) || node_online(node))
> -		return node;
> -
> -	min_node = first_online_node;
> -	for_each_online_node(nid) {
> -		dist = node_distance(node, nid);
> -		if (dist < min_dist) {
> -			min_dist = dist;
> -			min_node = nid;
> -		}
> -	}
> -	return min_node;
> -}
> -
>  static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  {
>  	struct device *dev = &p->pdev->dev;
> @@ -347,7 +328,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  
>  	memset(&ndr_desc, 0, sizeof(ndr_desc));
>  	target_nid = dev_to_node(&p->pdev->dev);
> -	online_nid = papr_scm_node(target_nid);
> +	online_nid = numa_map_to_online_node(target_nid);
>  	ndr_desc.numa_node = online_nid;
>  	ndr_desc.target_node = target_nid;
>  	ndr_desc.res = &p->res;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
