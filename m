Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10015BBC9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 10:38:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB26010FC33E5;
	Thu, 13 Feb 2020 01:41:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com; envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B252210FC33E4
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 01:41:13 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w15so5767610wru.4
        for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 01:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h+Vyr3wbXZdrL7js2MVthsgN+SvJforSfaGeRgZJbho=;
        b=g08Wqa5q4x/9J7wSqkOc+rjP4ziI3N0xyd/rSYD1wZIJQADKx36UZmgEERnOapb3i7
         TkfaeKx1QGNrhKhLE9kfTjH8LLFCgMi7IGft9ps0BiByygvO3oY1NLD7t0JXFkwcARKj
         MPL7XF6riqKatYo2UnupEyx5ZXDmWPPEMx0SVZx/teVg6Cw46TqxEnuQ9KCWZmJ9wWQp
         CE7taknqbwCsV6rZvPbGVpBtO/Fj1UElMGpJZDDlG46ZZc+RNPuoWFZw7gUjV9bsLCea
         hz9RXEnE4LPgllAnDJZ7EjFIfv2DgdBA1nqWQjfZLOTs0BAQDs5bddcsMwCLWcUiCrq4
         FTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+Vyr3wbXZdrL7js2MVthsgN+SvJforSfaGeRgZJbho=;
        b=X76WVbNirHOaQ5ZusdGjMjNarAKMttlzIvKjsdWM6Aio6Rzoyhz+EdMvOyiM9RDjDK
         Dv/KLFXU8CqG0gpbhvopMPj+tgPxuEvbHfi0/06NQxsSs/AVeedGfSuVmRSagUqiuOc2
         o1C6XQw4vgtVlY6phdhk/E/IGO7T3UNa3p3ouNvw4kOBc+CqCQCKH3hlsbhc3lP6H0py
         Cbsjs7175k6iPllQ1ULnCTYHwsDZqyuh1QMWTJSCPiVnyJ7naCIp8XQIGtHO0NlYpH83
         dGWDg1o3QIhkcwUvWc+lKX40IHb//lLVeAiIC5/HykKOeY/NO/VP7gHFGyGZN5Vfavz5
         KYaA==
X-Gm-Message-State: APjAAAXguDCrh1RKwrI0N0eCQ/TZRYkxHWWT8owOqu6C7osf/nAXU+2o
	tmKTtUBncpGY/H/48v6F95c=
X-Google-Smtp-Source: APXvYqxwoGKaMsWL2wnKe/IRRL/CBJ3mfrPEGF2PZ9bp2mxF7wP4t8ap9tXXLFMmVmqbp9n2aogPjg==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr19850159wrv.86.1581586675119;
        Thu, 13 Feb 2020 01:37:55 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x17sm2007821wrt.74.2020.02.13.01.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:37:54 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 13 Feb 2020 10:37:52 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 0/6] Memory Hierarchy: Enable target node lookups for
 reserved memory
Message-ID: <20200213093751.GC90266@gmail.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4j8ouOpaAEXELzKdr1m6cPWw=XOeRg4FqXPAgV3ZqUJoA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4j8ouOpaAEXELzKdr1m6cPWw=XOeRg4FqXPAgV3ZqUJoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: MKADW4DUOFMLWP3474TEVYLGEIGBIGIU
X-Message-ID-Hash: MKADW4DUOFMLWP3474TEVYLGEIGBIGIU
X-MailFrom: mingo.kernel.org@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kbuild test robot <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MKADW4DUOFMLWP3474TEVYLGEIGBIGIU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


* Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jan 21, 2020 at 7:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Changes since v3 [1]:
> > - Cleanup numa_map_to_online_node() to remove redundant "if
> >   (!node_online(node))" (Aneesh)
> >
> > [1]: http://lore.kernel.org/r/157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com
> >
> > ---
> >
> > Merge notes:
> >
> > x86 folks: This has an ack from Rafael for ACPI, and Michael for Power.
> > With an x86 ack I plan to take this through the libnvdimm tree provided
> > the x86 touches look ok to you.
> 
> Ping x86 folks. There's no additional changes identified for this
> series. Can I request an ack to take it through libnvdimm.git? Do you
> need a resend?
> 
>     x86/mm: Introduce CONFIG_KEEP_NUMA
>     x86/numa: Provide a range-to-target_node lookup facility

If the minor complaints I outlined are addressed:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
