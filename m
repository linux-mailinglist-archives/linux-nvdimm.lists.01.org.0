Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6A19DAFD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 03:22:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D426520215F41;
	Mon, 26 Aug 2019 18:25:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BC3C620213F05
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 18:25:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w4so17077955ote.11
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 18:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cthHw04i6S3cdZGMorj+KG6fhZrdavh1ItN5j6LDz6s=;
 b=cmYihnGBqwKlCQG5vvti9Rm7M6/bGuJt3jAB81YPZxsF3Ejvm3io0LL6JmHxTd36lY
 oG5/SJwY3iR1Zf0aR3/I1oLMK1Ri27qUV+sytVTzc6WF58o5SMOb7uNZMwohnG9t7g9B
 j1A4yMepdh7msqFXOJz45fN9ucKNoAIUQ41rJ1dUH3+0GO9qNeEmaaKc9IB+Pzgk1d+n
 LR8yNmUOmbaBNQJI0pXZy2PaRTszc9oEEdPzOGW5Glpqi12m0w6hPLepQP/3qkxhR1ah
 JJXjlIBm/P6tQ6ogG0IYtmXqttVGt2Bmd1w38KiI4RcOExItiR/TSWKEAHd8gcXGhuK9
 beeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cthHw04i6S3cdZGMorj+KG6fhZrdavh1ItN5j6LDz6s=;
 b=jpciwKGONgs14edwAVo+NkftVQ4puVTgAYkTndoi7YsPOJcJ5R/e/cTJwIS/jM/EPN
 jMFqMuS/zTRYRPSvZLwDlxKsis7LmBFsKYHpn1ZiV2ZoAWSqNcE6G8bzdu9Dr2vKRKzV
 jGJE3UX4Kh6Dp5DsDozvrK8Xp6978fpyBFvi74Y+yMHMIOILc34od5gM3Ej8ZS23FND4
 sKc1Nh5cuv7apMcQN+I5kO58SaX+K1J9F+GVNfhl03hMaHStCfgekjEnleebA6sGeoSE
 GLa52ZEdRDvJp72mjXFX8WmcA7uThKN+KPuGRwY68CCD7rvomPdOlD6plHucPNjTGjyA
 KXRg==
X-Gm-Message-State: APjAAAU2pEgHD72NyUwmZYmdQD4BUs+MXHemaPjC2ByDhGY+3cNDx/b+
 5U7LSlu3CyjmpCXyVsjXhwtH8YXjaPt4mUtg7P0eTg==
X-Google-Smtp-Source: APXvYqy58RonQUu7tSDf4oLxAHbEH/Vncd93vznxBhV0vDUjYrMBJmZqMzv1P00ZJmgD7sJNn+a8kaSc0Hrzcg0Tmdw=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr1249651otq.363.1566868975049; 
 Mon, 26 Aug 2019 18:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <1254901996.3735926.1564533684889.JavaMail.zimbra@redhat.com>
 <x498srsdhrs.fsf@segfault.boston.devel.redhat.com>
 <x49y2zfudej.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49y2zfudej.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 26 Aug 2019 18:22:43 -0700
Message-ID: <CAPcyv4hu+ShtryhDOaKUOHpw2LrHcqwB69oT10uVS4aORaJ66A@mail.gmail.com>
Subject: Re: create devdax with "-a 1g" failed from 5.3.0-rc1
To: Jeff Moyer <jmoyer@redhat.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 26, 2019 at 8:58 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan, we should probably fix this before 5.3 ships.  Do you have any
> concerns with the patch I attached?  If not, I'll submit a proper one.

I took a look. No concerns from me. Yeah, send a proper one and I'll
get it queued for v5.3.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
