Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A961EFE83
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 19:09:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0D0171009F03B;
	Fri,  5 Jun 2020 10:03:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D8B31009F039
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 10:03:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q13so8039957edi.3
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXYAuD6cJqilYclvO4FvsMZJybvzN9VYDs0VzjdhPnY=;
        b=t5puf6jywvyNN+70hb28Pvg47DXUPXRfy9clfajsTCTEsz1DVvuvmucmrFXPN4Yera
         iX5tmSkGaAyNZayciyT3GMyFrOCN4SMWL8M84IxZWnMlNodshGHe66dJPL3M3KK6I7au
         +Gg13yxDpSJdJwDAO/u+oQ8sXaQeYhxw/MvP+CTILg91x4xdp1wBvSxfUYgpmnTt/Mh1
         ptUOCyR+L/3/QbN0ianVVqfl1yyY1EzbmpTorznVSk6wXtS5PLZ7NKDsgw4KvfvqTugO
         4eHoGho3ymydRboxbZbhxWUgmRgJ6CgGhcQB5t8qPVtxxju5siJRkecD5se6dBe/h2N6
         0LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXYAuD6cJqilYclvO4FvsMZJybvzN9VYDs0VzjdhPnY=;
        b=IsXZWXHEQufCEu14bpdI8j1GONRiXqOVEoMEsEuLe9pFVrVSozVjZaAo0LYl6qJK/W
         WjMFYJaszbH24XV8MXvhkcqb/CEV4WcRKX81EVPLPSx50C5yZzY3SlvXc9jrWYDGRA7S
         cFzltcnDgl0N/jpy5dwK+fYSXnW6pJG+kLiuwa0mItM3ro8+K2jT/RhrTH+nyeBxcM0y
         n+9Mg/Udyixl/7otzQODE/h+SngHUVrQXJXBeEq7fxJ95wVI3UZJ5NGTASyqUfM7XPh0
         LDoJT6HDgelXUmn1OtbZsLk7DjmyfZpuo/iQ4mf1Rt3u6MiqO8Ro3p2FCMp/XYMQ9SEA
         hRpg==
X-Gm-Message-State: AOAM533CumhEJBPP+MJL1bshBcQI/FxH7TMoWXyZw8xsIlntksVNZ/4+
	S/Pz2xHy9OfGT0Mkv67AJOlw6mKu4nrovzW47uQqEA==
X-Google-Smtp-Source: ABdhPJxATfr/IFgw85Nm/0I0I4vMJ3s9Mbj4YTfektxdqlqB/pT+k/tztb3pG7J2zznxMo8KQcFTv2Q6AnRteS+UOLs=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr10040096edt.383.1591376944978;
 Fri, 05 Jun 2020 10:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2643462.teTRrieJB7@kreacher>
In-Reply-To: <2643462.teTRrieJB7@kreacher>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 Jun 2020 10:08:53 -0700
Message-ID: <CAPcyv4hWLKP7fdLhWLn8vxf5rJKvKyU0yLfDs0XMjW-9U9tM-g@mail.gmail.com>
Subject: Re: [RFT][PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID-Hash: 25HI7BP3J4BFM6BY3GIT67LPF3JBB6AQ
X-Message-ID-Hash: 25HI7BP3J4BFM6BY3GIT67LPF3JBB6AQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Rafael J Wysocki <rafael.j.wysocki@intel.com>, stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/25HI7BP3J4BFM6BY3GIT67LPF3JBB6AQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 5, 2020 at 7:06 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] ACPI: OSL: Use rwlock instead of RCU for memory management
>
> The ACPI OS layer uses RCU to protect the list of ACPI memory
> mappings from being walked while it is updated.  Among other
> situations, that list can be walked in non-NMI interrupt context,
> so using a sleeping lock to protect it is not an option.
>
> However, performance issues related to the RCU usage in there
> appear, as described by Dan Williams:
>
> "Recently a performance problem was reported for a process invoking
> a non-trival ASL program. The method call in this case ends up
> repetitively triggering a call path like:
>
>     acpi_ex_store
>     acpi_ex_store_object_to_node
>     acpi_ex_write_data_to_field
>     acpi_ex_insert_into_field
>     acpi_ex_write_with_update_rule
>     acpi_ex_field_datum_io
>     acpi_ex_access_region
>     acpi_ev_address_space_dispatch
>     acpi_ex_system_memory_space_handler
>     acpi_os_map_cleanup.part.14
>     _synchronize_rcu_expedited.constprop.89
>     schedule
>
> The end result of frequent synchronize_rcu_expedited() invocation is
> tiny sub-millisecond spurts of execution where the scheduler freely
> migrates this apparently sleepy task. The overhead of frequent
> scheduler invocation multiplies the execution time by a factor
> of 2-3X."
>
> In order to avoid these issues, replace the RCU in the ACPI OS
> layer by an rwlock.
>
> That rwlock should not be frequently contended, so the performance
> impact of it is not expected to be significant.
>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Hi Dan,
>
> This is a possible fix for the ACPI OSL RCU-related performance issues, but
> can you please arrange for the testing of it on the affected systems?

Ugh, is it really this simple? I did not realize the read-side is NMI
safe. I'll take a look.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
