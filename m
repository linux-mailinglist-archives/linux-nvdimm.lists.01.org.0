Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31B3705D2
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 May 2021 08:05:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D3174100EBBDD;
	Fri, 30 Apr 2021 23:05:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 005B8100EC1CC
	for <linux-nvdimm@lists.01.org>; Fri, 30 Apr 2021 23:05:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id di13so518365edb.2
        for <linux-nvdimm@lists.01.org>; Fri, 30 Apr 2021 23:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIH9dEzJm2MQOcg3ITNPUNWC3JDsppBcgWWVf5bWNec=;
        b=k2n+qDM2QnLyXCSq+fNMwX71M9LISscTmg9en2dJzmWS4VMPKR5zbcpVl4d01LIGy/
         p5ha7V0f/1J+qeNVgLOgal+q25ICfRkxMJS52qXqrnrMUCMXcYJSXgHTLJ55K4IUyXRk
         6+K2DhCYuOS9iuvrW4plc6YUcCWHDxL7MSj6sF2Y8p1GUwNlGMcaMGc3xOUOhNfKGXL4
         KwY9rCnxYnW0lTBPLMVing2hyjHluMC4yX9u/8eQvMCoswy41c9GVXrSPlSnVXBQlnNi
         OYjUR5/n6jYyq+lvYZEioDFt8d6Zw72OGNhF78obr3s5TAMqKnt6VInAHfSH65iA3gCt
         RaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIH9dEzJm2MQOcg3ITNPUNWC3JDsppBcgWWVf5bWNec=;
        b=hE6qDROs/dZ889b92cw/blC5hVg8iGr44kTgbNA1B/NHy0prlHYeS3wHztTvlKx5Q/
         /gP8TbmfOqFXVHKU5+H6oi/FSVHx0+wkvwRgE32yxaACpO1v69QtL+HqURpPOgHenWUG
         8SGikU2HAccV7p+Y2lFERd/HLDSlkUcF31fc5GGTYvFoyQAmigOokRSeJWiLHLTuIHzl
         uztY4MlVmbGwn0IMlIrkflZgnqkvbMmaMdZZFx410ZOmQBLaCJGqSH8FYa/y8NjcNMwH
         KHG9f9w7iKcucWMslXfXqOMcmffm5B2Fn4oZuqje2J0NsFz3t5Oy1wOdoqo1X0zFuPsn
         S49g==
X-Gm-Message-State: AOAM532XAD+Es7GxFGQSW6sd4izYnN//1eDjR50NG2oUEj1BZd5ZCXGJ
	75tiaSZLkhRnC3QCqv8K4Q51mw49H5TfyN0xJbknvA==
X-Google-Smtp-Source: ABdhPJxZ268Oj+/hvmGi/Jxj8L3W86XUR3U3/hK0+F+i3xgfwF1DX3L2OpW1PlVL7xAIP2gzGg+xd+69p4yGUO+gVRA=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr9876687edx.52.1619849148086;
 Fri, 30 Apr 2021 23:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9s25EqRhL6_D5Rg_7j14N5UVODJ0ps4=4n7sZ6zE5U3w@mail.gmail.com>
In-Reply-To: <CAHj4cs9s25EqRhL6_D5Rg_7j14N5UVODJ0ps4=4n7sZ6zE5U3w@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 30 Apr 2021 23:05:48 -0700
Message-ID: <CAPcyv4iuA=+aUOgHvYXtg8D_1RSxjrZC4cG2GXVhEZVeQCD5rA@mail.gmail.com>
Subject: Re: [bug report] system panic at nfit_get_smbios_id+0x6e/0xf0 [nfit]
 during boot
To: Yi Zhang <yi.zhang@redhat.com>
Message-ID-Hash: LNF4SS2LZGG7FCMHSWVB4IR4QN4LK5R5
X-Message-ID-Hash: LNF4SS2LZGG7FCMHSWVB4IR4QN4LK5R5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LNF4SS2LZGG7FCMHSWVB4IR4QN4LK5R5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 30, 2021 at 7:28 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hi
>
> With the latest Linux tree, my DCPMM server boot failed with the
> bellow panic log, pls help check it, let me know if you need any test
> for it.

So v5.12 is ok but v5.12+ is not?

Might you be able to bisect?

If not can you send the nfit.gz from this command:

acpidump -n NFIT | gzip -c > nfit.gz

Also can you send the full dmesg? I don't suppose you see a message of
this format before this failure:

                        dev_err(acpi_desc->dev, "SPA %d missing DCR %d\n",
                                        spa->range_index, dcr);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
