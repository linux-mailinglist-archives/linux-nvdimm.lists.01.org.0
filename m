Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B030FEF8
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 22:01:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29347100EAB0F;
	Thu,  4 Feb 2021 13:01:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D6ABE100EAB0E
	for <linux-nvdimm@lists.01.org>; Thu,  4 Feb 2021 13:01:37 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id y9so7885733ejp.10
        for <linux-nvdimm@lists.01.org>; Thu, 04 Feb 2021 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s/yIzssAJEogX8QL3PckAQf7VpPhtvWTp1CrCg9cJI=;
        b=LVKt1Jlg3viOJCnY9KgBaZrpObq3g8tFou+0PefdJnZLo6tvXDeCkMkUhDvJZ07B3g
         lTidacUKRZ1vCypk6VTJ5SuTfea3fUaMCdK9Bv8rmr6R/sOHmhRwtZrtxrUoWAo4absE
         m9RM2D02QLapaVpgAI6iyiLk48DoxHPiWNys7RIl+4fPi1YAqxCWWyoaOecXPrIHAXZ5
         hDIRSUEeOz0OSO+pSEfJ1sf+M5TKBhUA6UHdbSMVd+l+GXCRHLNVE3q7aTpK8zJkluMT
         hfc+Jgi+5RjaJX8OAeCcCvAxwMeDCMboKnHsWrWkYRtZq15chxB+vgbbT3QWMcyKsf6M
         lkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s/yIzssAJEogX8QL3PckAQf7VpPhtvWTp1CrCg9cJI=;
        b=hoUiz+snEvrS8EnxxZzp7sxuQkWqK2tFggvaoU8KoU6zeFVcrb+PUiKupakAbR6zg/
         BeZL83lBt1HASqt68B6JhBQfXGw7D+lSxh5KQLQ7Xq9Oso8D+jaSgIrooKeccIcHz4uj
         PEWRhSIzo8ZhkgPKb4gh96nKPM6n3Hxgpnsgus/WX8Anp+KfMTVhn3cbS/EBo+mjQOyu
         ZEYLXhC3kCLifVubiFP3OgcGqQi3oBxkprWN+7y0m5/5GKVRm53SNH0HUJIXMFlXEQeV
         4Fj3oS5FDv+WNNY1H9fPoJqUFuzmwin+fv5TnicVdzCQRK3CTm69o762mLz75pdQCVCU
         zRbQ==
X-Gm-Message-State: AOAM531Qtiju5HC6kLwd9az997WUTigY7+umELA+s6h7aFrL0DlrT8sM
	QkrOl/aFtlSYjHlb96allrmP0vkmffLjKgroGcP+wg==
X-Google-Smtp-Source: ABdhPJyHp/zY/gWK0OHwxd1OKIX/x+WfdHoU/hR/Dv5qm54B4zuu4eKGOX6BEyUFFddG59yitMp3iDRQpdDKA7E6P3w=
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr920058ejb.523.1612472495097;
 Thu, 04 Feb 2021 13:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com> <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com> <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
 <20210203171610.2y2x4krijol5dvkk@intel.com> <YBroGrVd76p+BF0v@Konrads-MacBook-Pro.local>
 <CAPcyv4hMM9isho5d8wS=5vtP0NxE5KA0HrMp+Bx2PZhPDrrWsg@mail.gmail.com> <20210204185540.oxwurggwd7a37a2o@intel.com>
In-Reply-To: <20210204185540.oxwurggwd7a37a2o@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 4 Feb 2021 13:01:35 -0800
Message-ID: <CAPcyv4jmZ_NcR4yX2mMV6qkhxkKvg3qYenkQGPcF1TvvFXf-oQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
To: Ben Widawsky <ben.widawsky@intel.com>
Message-ID-Hash: X3QA7H3VDHBGRUQFNXJFHRZ2LVAK5R7Q
X-Message-ID-Hash: X3QA7H3VDHBGRUQFNXJFHRZ2LVAK5R7Q
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X3QA7H3VDHBGRUQFNXJFHRZ2LVAK5R7Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 4, 2021 at 10:56 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> It actually got pushed into cxl_mem_raw_command_allowed()
>
> static bool cxl_mem_raw_command_allowed(u16 opcode)
> {
>         int i;
>
>         if (!IS_ENABLED(CONFIG_CXL_MEM_RAW_COMMANDS))
>                 return false;
>
>         if (security_locked_down(LOCKDOWN_NONE))
>                 return false;
>
>         if (raw_allow_all)
>                 return true;
>
>         if (is_security_command(opcode))
>                 return false;
>
>         for (i = 0; i < ARRAY_SIZE(disabled_raw_commands); i++)
>                 if (disabled_raw_commands[i] == opcode)
>                         return false;
>
>         return true;
> }
>
> That work for you?

Looks good to me.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
