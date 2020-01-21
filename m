Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B31435D6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jan 2020 04:09:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40ACD10097DD5;
	Mon, 20 Jan 2020 19:13:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73A4C10097DD4
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 19:12:58 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id a15so1693332otf.1
        for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 19:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzgAN7AcFUKo31VzGca5wqU7jl5yRWzRRc+tIT8IsdI=;
        b=oW3qFX6l83ZPQ5G+hzzgXNelFpIMqlQxZNmoDJwHEETifAbTlPlyCkKOG/yDY6znYu
         eq+wXWMOKkn3fK14gRz7UFjvSx4GuJk+LPCb1DrJune8B8chnaQ553KHRGJaT9T21cE6
         jBkp5CXNJjdaDhDB7fqCe/e5O3HuPplIhnB9gL2iRSn/l1VOhSAPY4LJ/YeJI35pajl4
         5P3P6lxIGDRCxpHvJrssmgEZQJUqCQkdHOC4tDTEyZeQaSoRb11zEfDqjyRkkaZhYs+W
         Q/3mvi/8xpCiv3ZHgRNo7CFBberN8G34sdZnmz0QKqXZI0N0CzmeRyE8geQxIKMxVcYP
         JbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzgAN7AcFUKo31VzGca5wqU7jl5yRWzRRc+tIT8IsdI=;
        b=NzJpw+V1+MXll2Njw9Q/HQpvZ5XMEQFiSRiHYe0ASLsr5xT2MTdQTXvzNUu3JWoL5R
         7+4RPe5jyknwQ6c+zQIu11H00aSH01EEieohhFvmJo8+1Rpxc4cBAnkq/3eKe1t7HkKN
         IPyZhkEL5yUgcle1jVfUH+EYYj09DQBhsRgZlKtpUydSrhY9SmMeYEnwwvsNJ4s4yfi2
         9sUo+prXxJzkcw6betNrw4R1n5PxiWR4+Wk6qClhDf1KLdvhU3PeM+bEyrYKVqkiPDwX
         7wBW3mK0JyDMz9iG5RSEoPbt9VqR7hR9NmnRV8K4AAyDDMYLNrwdP50it83bMmFuGzyk
         e4Xg==
X-Gm-Message-State: APjAAAVeqfCSP5vkEpCC/lQsnCdayc7CX+Posv6NveXQfwbrfncrqMUG
	c1o2eKYcHFL1EvQtgC7bNZ8Gfoq/Rab1buvewtRnmQ==
X-Google-Smtp-Source: APXvYqyWPPBlFl8k77ykQtRhabA6jR2wpAyFXUn7yE9w3Z0qz05h9scPEucgncq36HL8MGc82zVafvBeR8O9Z99ZFJ8=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr1984867oto.207.1579576179419;
 Mon, 20 Jan 2020 19:09:39 -0800 (PST)
MIME-Version: 1.0
References: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157954697957.2239526.17206272633668977957.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87pnfdd20d.fsf@linux.ibm.com>
In-Reply-To: <87pnfdd20d.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 20 Jan 2020 19:09:26 -0800
Message-ID: <CAPcyv4gjuk1OOnT2oobXXKS-d5DMFqrwbb-LCbG+0aexh_83sw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: E3ACBJ4NBCDGNKR44ISO7E6PS5NA7GGH
X-Message-ID-Hash: E3ACBJ4NBCDGNKR44ISO7E6PS5NA7GGH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E3ACBJ4NBCDGNKR44ISO7E6PS5NA7GGH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 20, 2020 at 5:36 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Update numa_map_to_online_node() to stop falling back to numa node 0
> > when the input is NUMA_NO_NODE. Also, skip the lookup if @node is
> > online. This makes the routine compatible with other arch node mapping
> > routines.
> >
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Link: https://lore.kernel.org/r/157401275716.43284.13185549705765009174.stgit@dwillia2-desk3.amr.corp.intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  mm/mempolicy.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 4cff069279f6..30d76db718bf 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -137,8 +137,8 @@ int numa_map_to_online_node(int node)
> >  {
> >       int min_node;
> >
> > -     if (node == NUMA_NO_NODE)
> > -             node = 0;
> > +     if (node == NUMA_NO_NODE || node_online(node))
> > +             return node;
> >
> >       min_node = node;
> >       if (!node_online(node)) {
>
>
> The above if condition will always be true?

No, not for the node_offline case, and that's typically what callers
are passing.
>
> -aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
