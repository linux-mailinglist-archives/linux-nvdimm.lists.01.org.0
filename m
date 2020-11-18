Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89412B7827
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Nov 2020 09:08:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5700E100EBBC9;
	Wed, 18 Nov 2020 00:08:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 881B2100EBBC7
	for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 00:08:17 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q16so983906edv.10
        for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYkzksRNaGbOMgyJtFrKrhjpOwtjgLuKKLI9H1meENs=;
        b=xCWG2WDkXGUHEmmvlIEXs8mX9u3sb6FB0q9LFul6OKzhcg+CIPpbHyWVJyUIcZ6U0c
         CxzCSvsRY1fmsdf7hUe3PrzVMR4XzcBUH5/oDkRiRzgCDh1l3MGg9f7qpopJPDhA/Osf
         naXIzRtC+tCcAsimW4BCW/g1+nTYFw7Px93SotOJsq6n0lSPMi1qM3+8nb320uD64Ba8
         gLMznJOGDpF+y5CXx6brPuOqhhmOYYTNKbiw7OmMCngWtim6jtwlUlja+b94KEBDE01Z
         cClj/K8TpXVCCPjufmUZeja80w0hx/6KOG/M8vvoGE9/WY1lxBvSZ/eKf0rV7Sw9spuE
         MEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYkzksRNaGbOMgyJtFrKrhjpOwtjgLuKKLI9H1meENs=;
        b=eRn2K12mdwSjEaqMvD5eENaCvKm+4CXGv+BrdIm/6tzbd6nsID3IssbDViSsKiV43/
         zuzGpfMk7HNLoWAQFzIC0Jjqk4whiXJAYl0HbwkRDSGXjVuBnLgL8Kx0ZKoZpf+xsVlk
         Myn13ii01UUZgs/dFe/gyoecGhd7W7f0UCjhl2UoJ9aBXYB1rpKk4XN+TCR5dB0GKsES
         rDOzXlnxk3UJKknm0ykIixOYph5woMRBIvSt1juXM/DE66BlN5RmlIjvPJpO43sniprs
         r0ZGx9BhKzrtoEvjfS3rUBmDSQCsNBEaFu9n0bZlRgTwV6tjwbEZHx10O4UqBPM79O4p
         og4g==
X-Gm-Message-State: AOAM532knsDzXPIodVfQ0++jaZ+xw7plbEKjoScCSdiXMY+Beho/tg0W
	SaUrNqj4kA8DKXMjr5lHlfMc9C+nTMSWF6I6K/pTKA==
X-Google-Smtp-Source: ABdhPJyIpjJgJazX4fTSFDsxCZTxH/xxyf4fTir1+gkSOwPp8hbM6quT/hXeCY699yN511XwzGCCUFGquOJ6Buwje7k=
X-Received: by 2002:a05:6402:144f:: with SMTP id d15mr25196770edx.300.1605686895096;
 Wed, 18 Nov 2020 00:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20201118073517.1884-1-thunder.leizhen@huawei.com>
In-Reply-To: <20201118073517.1884-1-thunder.leizhen@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Nov 2020 00:08:03 -0800
Message-ID: <CAPcyv4iECY-XoJ=jhARDDqjv-j8fnOUiKxB9Z+M5J+kMoeeWhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI/nfit: avoid accessing uninitialized memory in acpi_nfit_ctl()
To: Zhen Lei <thunder.leizhen@huawei.com>
Message-ID-Hash: TIPN7UF5HCWDKWWVFNYPLQTHOAPIFGQ2
X-Message-ID-Hash: TIPN7UF5HCWDKWWVFNYPLQTHOAPIFGQ2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TIPN7UF5HCWDKWWVFNYPLQTHOAPIFGQ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 17, 2020 at 11:36 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The ACPI_ALLOCATE() does not zero the "buf", so when the condition
> "integer->type != ACPI_TYPE_INTEGER" in int_to_buf() is met, the result
> is unpredictable in acpi_nfit_ctl().
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I'll pick this up.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
