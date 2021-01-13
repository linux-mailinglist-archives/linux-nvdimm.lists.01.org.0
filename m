Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C242F44D1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:08:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9FA34100EB85F;
	Tue, 12 Jan 2021 23:08:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6EE75100EB85D
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:08:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id 6so1573669ejz.5
        for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Cv3Ugc6uajFKPtCUMbRvHQ5TSV60TsOOjtcX28EeM0=;
        b=CHVDr5MBQynAnsMYWgWk1OcLi8JYMzzi+iqWUddjgAlKp4jldVqBEDojDW+4Tsx1mb
         SPL9V3tT/1JVq2MtYLTaiqTmo3h0K22cEwzPmqGwqAk8ORyl4LNdyuPxoI9loacvVNb9
         x0XZZKPrzm1YS5WHdkMa6ozOS9CJ28HdhbuK8n2W3di9PxVatMLr1K0cqt/mGihUbHc6
         rTusc9W+nNyrYkgf1rh4P+BSKCup6ks+O30g7ym34fGHCHWAmxg2K1CSXOx3zXZGlyvk
         ldDVStCjsAepSr2NSIaHxWnto4ZPDCqJcQdtdRWpTskwm7qGbDPVRaVzeUwSUM4UVK/W
         85zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Cv3Ugc6uajFKPtCUMbRvHQ5TSV60TsOOjtcX28EeM0=;
        b=fSvZUUAjDP5uc78k6Mcz6bPaZGrNy181LCHWgp00xyJh22ksyJiq5V+Rx4GDRyOVuh
         qm498Y0Z2oUGAlM+6ti03ju4lVhkczliWorg5BP2y53ks1FJJbfVxOGeZlU72vcyo6Gx
         A502rBw8gHmFm5+GmSC1uq1vbW/puFJY6vZxdMMWEz7f1nYx93eU0yiznPl1YB/OTOaX
         lENIKvOLr/QJRMEvhfE6fWAG2O+YnlTmwWMehU5OBYsyMW+p5SPqfagJb4vm0Q2BjT5S
         dU8NDsvMyc2ZezQmaLl8ggSS1MkGcG5bFxcBeULYiqyVpCH8bVLi0WRbea9OFc2yGzAY
         qEzg==
X-Gm-Message-State: AOAM5306xTF6VqRkxnlzlV+AO1eNTpntssOcDWDlQtI8rsVG4GmMVSni
	VlKZt0N5j5xNkbvSuCoFtKJPsc2R5Z757lr4faF4ew==
X-Google-Smtp-Source: ABdhPJyNx0poQirsSSzfGSs+KmV0/MR/3/xsLY1RJKIbvBaYksQ3ZRzVOiq63MU9IvBpauIHpipLRdJly+zRvu84HbU=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr558606ejk.323.1610521679943;
 Tue, 12 Jan 2021 23:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20200426095232.27524-1-redhairer.li@intel.com>
 <CAPcyv4gLKSMa4bN446MnRtjdfGaM-Hjy+dcYm316=4EP43G1wg@mail.gmail.com> <BL0PR11MB3281CBD1CC9B64389731ECE492AC0@BL0PR11MB3281.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB3281CBD1CC9B64389731ECE492AC0@BL0PR11MB3281.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Jan 2021 23:07:50 -0800
Message-ID: <CAPcyv4gupvktDG2PdCL6SyO4gwC1WoP8PKmPv1gP6pp8i10esQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
To: "Li, Redhairer" <redhairer.li@intel.com>
Message-ID-Hash: 2WVWUNFGY4EF3MHJD4PEGG4DI5ZBHNSJ
X-Message-ID-Hash: 2WVWUNFGY4EF3MHJD4PEGG4DI5ZBHNSJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2WVWUNFGY4EF3MHJD4PEGG4DI5ZBHNSJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Redhairer, sorry for the long delay circling back to this...

On Mon, Apr 27, 2020 at 6:10 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> If make this return 0 in the case when size is zero, then seed device will be counted in due to
> case ACTION_DISABLE:
> rc = ndctl_namespace_disable_safe(ndns);
> if (rc == 0)
> (*processed)++;
> break;
> I ever think make it return 1.

I think returning 1 is the right answer, because this isn't a failure
and there are several other places that call
ndctl_namespace_disable_safe() that need to be updated to treat rc < 0
as failure and rc >= 0 as success / no disable necessary.

ndctl/namespace.c:1127: rc = ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-1128- if (rc)
--
ndctl/namespace.c:1433: rc = ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-1434- if (rc) {
--
ndctl/namespace.c:1457: rc = ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-1458- if (rc) {
--
ndctl/namespace.c:1480: rc = ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-1481- if (rc) {
--
ndctl/namespace.c:2215:                                 rc =
ndctl_namespace_disable_safe(ndns);
ndctl/namespace.c-2216-                                 if (rc == 0)
--
ndctl/region.c:72:                      rc = ndctl_namespace_disable_safe(ndns);
ndctl/region.c-73-                      if (rc)


> It also can return correct number which not count in seed device.
> But there will be no error msg when I disable seed device.
> It will make user confuse.
> Eg.
> root@ubuntu-red:~/git/ndctl# ndctl/ndctl disable-namespace namespce0.0
> disabled 0 namespace

Why is that confusing isn't the namespace already disabled?

>
> So I follow enable-namespace to return -ENXIO and it will look like
> root@ubuntu-red:~/git/ndctl# ndctl/ndctl disable-namespace namespce0.0
> error disabling namespaces: No such device or address
> disabled 0 namespaces
>
> But no matter return -ENXIO or 1, it will make test/create.sh fail. This is why I modify region.c

region.c and several other places need to be updated. I would split
this into 2 patches.

The first patch updates all callers of ndctl_disable_namespace_safe()
to treat rc > 0 as success.

Then the second patch can treat cmd_disable_namespace() to not count
rc > 0 as error, but also don't count it as disabled.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
