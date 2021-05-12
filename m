Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0181037CF01
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 May 2021 19:27:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50D4C100EB35A;
	Wed, 12 May 2021 10:27:43 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D2A45100EB82B
	for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n2kSoXVjaG6r/aRDrddKurJtkE5bpmO12SFICV7/2rE=; b=ZCckaik/4Prk5oi4ppy8WJzuW4
	nMhmnAJ6FhRh+cGcStqFfzAxzUYoLKu7uWpd6N0+p+m6Ol9szTYKuoPRhBS3HHp4wbb2n45QYWavW
	NrBKSL15dNcdwdd8tEaK1m/BAa94fJ71hw4hCVLBIK6yxSUCqcII+5YPaGKv2YFN92QLBdgN6PbrN
	Y7m4ECNGxX2KjnGxg2eLznHogcNf5Vou9OW54nIPIoKVIMUr90N0Vda8SFRUB+sUtHvmcRfhYyPD1
	onFNWEGt73nEjCm0n4w8+HSa7kAE+YnicCAtpcoWNn37s+VRqe5qfB03G/J76CmNYIltOLAIHKwCd
	vCEBpQ3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
	id 1lgsdm-003RZC-JK; Wed, 12 May 2021 17:27:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F7313001E1;
	Wed, 12 May 2021 19:27:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4BBF020B6C70F; Wed, 12 May 2021 19:27:16 +0200 (CEST)
Date: Wed, 12 May 2021 19:27:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [RFC 1/4] drivers/nvdimm: Add perf interface to expose nvdimm
 performance stats
Message-ID: <YJwP9ByvAcDPixVN@hirez.programming.kicks-ass.net>
References: <20210512163824.255370-1-kjain@linux.ibm.com>
 <20210512163824.255370-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512163824.255370-2-kjain@linux.ibm.com>
Message-ID-Hash: H6LOG2QI4G5QUSUYLUQG73R45B5FGK7Z
X-Message-ID-Hash: H6LOG2QI4G5QUSUYLUQG73R45B5FGK7Z
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, atrajeev@linux.vnet.ibm.com, tglx@linutronix.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H6LOG2QI4G5QUSUYLUQG73R45B5FGK7Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 12, 2021 at 10:08:21PM +0530, Kajol Jain wrote:
> +static void nvdimm_pmu_read(struct perf_event *event)
> +{
> +	struct nvdimm_pmu *nd_pmu = to_nvdimm_pmu(event->pmu);
> +
> +	/* jump to arch/platform specific callbacks if any */
> +	if (nd_pmu && nd_pmu->read)
> +		nd_pmu->read(event, nd_pmu->dev);
> +}
> +
> +static void nvdimm_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct nvdimm_pmu *nd_pmu = to_nvdimm_pmu(event->pmu);
> +
> +	/* jump to arch/platform specific callbacks if any */
> +	if (nd_pmu && nd_pmu->del)
> +		nd_pmu->del(event, flags, nd_pmu->dev);
> +}
> +
> +static int nvdimm_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct nvdimm_pmu *nd_pmu = to_nvdimm_pmu(event->pmu);
> +
> +	if (flags & PERF_EF_START)
> +		/* jump to arch/platform specific callbacks if any */
> +		if (nd_pmu && nd_pmu->add)
> +			return nd_pmu->add(event, flags, nd_pmu->dev);
> +	return 0;
> +}

What's the value add here? Why can't you directly set driver pointers? I
also don't really believe ->{add,del,read} can be optional and still
have a sane driver.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
