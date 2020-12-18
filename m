Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB422DE9AD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 20:21:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C6C9100EB343;
	Fri, 18 Dec 2020 11:21:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 514C5100EB342
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 11:20:57 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qw4so4740520ejb.12
        for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HEr0MPReqXsQ4qjOEHDWj7dDqEmzb7cQ1SBc7J5+dw=;
        b=0gUyIB6kwj5RKOw851fk6tIuNDG4efEdNNdTwLooyi3Ofm0EJNVeG9KuAjSj3aMg6f
         Nwg+eoJoWVdwLtTY3Y8taw8Fef0vS6Q+iXd/8DHKpkBDllC+QxxTWM+tmflFQ56pKF9B
         r2XxuUfLtlwWmeTgBIAJmw9ETjSzKJTBTFdP2PkwnVqnR01L9FpICe97GYFCb2DWdW5K
         seQ68bOOeWzb3UjT1JmBfrvoBnu9/DfF7C6IExaFWhrhWglsaMg1lwmZ33uUG9d1/Sb+
         XYVWsgUrBCaZCqgbA6uAiGkasFBAenXSTwAqf6Hsd5Vrz7GPCAPk7LmnxkGUwVTkpXZL
         KpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HEr0MPReqXsQ4qjOEHDWj7dDqEmzb7cQ1SBc7J5+dw=;
        b=FMEcFFUlrKcNr2biEAZ/1mnoeCL5G995+ceiGRXGJd/Sdg6lCz1IGpH3+evb8wr7gj
         +VQAgEaNlpel95AJqVXC7GiK2zh0/vQHvNwJAQ0acyZry++g8hO2HFpKWWJ5qtVcGDov
         l7QXXVzbhrF3bGRthgrIznhTKQk8af//qXy4OmBffgHwep+N4BskjDknjXy7TXeXufDH
         H+Wc/A7hEwxcQ7wkEIa+eCr2xM5rFxiIcW5TWlr8Gleuz0fx3cO3rZKMp8FQeGNnnBW4
         kLhCBfTq9IJL3AOGYaGu9ldNs6mR1jtqi8adCfxwCErAhq8HXfKFXRJrrPWeYZtGc2vv
         XMoQ==
X-Gm-Message-State: AOAM532vJjcHq/Cru1CRPWFPsFrw7y0Ja9TCf/F/mxFsMIQhSl2ijNw8
	LeKXhEyqbBACn11+AWPzDrMWtNESOxwAiyPvpEMluA==
X-Google-Smtp-Source: ABdhPJxz1FpFcD9v7zRsD1EJK/j02c+zOqLAfDerue66a4zrExXDdPTJUW4Jq8q7kbLcuvcZiWDBKJ5jeXELTUS5XC8=
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr5459331ejk.341.1608319255787;
 Fri, 18 Dec 2020 11:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com>
 <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de>
 <878s9vqkrk.fsf@nanos.tec.linutronix.de>
In-Reply-To: <878s9vqkrk.fsf@nanos.tec.linutronix.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Dec 2020 11:20:45 -0800
Message-ID: <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID-Hash: CDYR2DCS77MWZAKMIUSKS6DZ6NJQ5OBX
X-Message-ID-Hash: CDYR2DCS77MWZAKMIUSKS6DZ6NJQ5OBX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CDYR2DCS77MWZAKMIUSKS6DZ6NJQ5OBX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 18, 2020 at 5:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
[..]
>   5) The DAX case which you made "work" with dev_access_enable() and
>      dev_access_disable(), i.e. with yet another lazy approach of
>      avoiding to change a handful of usage sites.
>
>      The use cases are strictly context local which means the global
>      magic is not used at all. Why does it exist in the first place?
>
>      Aside of that this global thing would never work at all because the
>      refcounting is per thread and not global.
>
>      So that DAX use case is just a matter of:
>
>         grant/revoke_access(DEV_PKS_KEY, READ/WRITE)
>
>      which is effective for the current execution context and really
>      wants to be a distinct READ/WRITE protection and not the magic
>      global thing which just has on/off. All usage sites know whether
>      they want to read or write.

I was tracking and nodding until this point. Yes, kill the global /
kmap() support, but if grant/revoke_access is not integrated behind
kmap_{local,atomic}() then it's not a "handful" of sites that need to
be instrumented it's 100s. Are you suggesting that "relaxed" mode
enforcement is a way to distribute the work of teaching driver writers
that they need to incorporate explicit grant/revoke-read/write in
addition to kmap? The entire reason PTE_DEVMAP exists was to allow
get_user_pages() for PMEM and not require every downstream-GUP code
path to specifically consider whether it was talking to PMEM or RAM
pages, and certainly not whether they were reading or writing to it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
