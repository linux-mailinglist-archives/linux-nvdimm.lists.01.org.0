Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695F63808DA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 13:47:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F5A1100EAB0D;
	Fri, 14 May 2021 04:47:28 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 09EE5100EAB48
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9+rh5toy6w7tSZKTYyXb9xGpei7fnwqJwkaQ76SHrhM=; b=RhZRKiZs8yRPgN+DkBxlK/W39E
	EDrXRZzdDv4sK9rr+ahPrxlAV+O+mOfCQmwpX30btZfKLkkMtmEb66RPvTy2aFcP/bzCXYi5nsIsE
	w4jZwGTiMbqPww8VUZ24dl81dUO2Ij8JPHS4SWrftGxqE6DHHzvWk6vQZcvpj7lA8MajQPM3rp8ct
	meAaSN+khRlZ4XBBwGOSKFYwL8nnffi+vJtZFR3r8tF7ae39CFt2qOhWF9LAz9hGsV4K+Ll5ru3oi
	yIJ+MIrrmIJXIj6RBIWTUxMkLwWq713CONMFpeLKEDzildtr4YQxa6vuoE/0WUDdC+bR8Gi8+WNAw
	DMHgGQzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
	id 1lhWHl-007xqp-1z; Fri, 14 May 2021 11:47:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2F7A30001C;
	Fri, 14 May 2021 13:47:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B67B20829F97; Fri, 14 May 2021 13:47:15 +0200 (CEST)
Date: Fri, 14 May 2021 13:47:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC 1/4] drivers/nvdimm: Add perf interface to expose nvdimm
 performance stats
Message-ID: <YJ5jQ1ixz7D0Ij2R@hirez.programming.kicks-ass.net>
References: <20210512163824.255370-1-kjain@linux.ibm.com>
 <20210512163824.255370-2-kjain@linux.ibm.com>
 <YJwP9ByvAcDPixVN@hirez.programming.kicks-ass.net>
 <37015d53-050a-acef-2958-b1ff5d02800b@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <37015d53-050a-acef-2958-b1ff5d02800b@linux.ibm.com>
Message-ID-Hash: OGDV5AFMDLJDWMXBFHZICH3NGLVCCCG6
X-Message-ID-Hash: OGDV5AFMDLJDWMXBFHZICH3NGLVCCCG6
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, atrajeev@linux.vnet.ibm.com, tglx@linutronix.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OGDV5AFMDLJDWMXBFHZICH3NGLVCCCG6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 13, 2021 at 05:56:14PM +0530, kajoljain wrote:

> But yes the current read/add/del functions are not adding value. We
> could  add an arch/platform specific function which could handle the
> capturing of the counter data and do the rest of the operation here,
> is this approach better?

Right; have your register_nvdimm_pmu() set pmu->{add,del,read} to
nd_pmu->{add,del,read} directly, don't bother with these intermediates.
Also you can WARN_ON_ONCE() if any of them are NULL and fail
registration at that point.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
