Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623DB20694E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 03:03:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 708F010FC4AD2;
	Tue, 23 Jun 2020 18:03:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B9EBC100AA7BA
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 18:03:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g1so214474edv.6
        for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 18:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo5cTIL37FpYiHosBDpvR4kZAwB7mWQXF34HqE6NXHo=;
        b=KYVTXVXkCqMbcVuFTDEDKDF/vl50d6y6AVcDR3VWHAdVtg0rVF+rufFQ1wEqaxVJxh
         SIb5YPrtFiiuP3U/USOvpvsCngwFcKcauttqEoZunWAugH4tljXQUnJSNiIjDNlSZE/Y
         8vINYeh9lbMfW+YemTuHtIAKi4Sl9PXz4gZiOGRJUuGUwoyGoQmUiLV5cCSbIz4EaasJ
         92s42xO9NEEqZm68/Q83e/Ak5uUYC6GXyyuUfu/VrtqYiplckhU03c0Vgvov8YbQnCav
         /XiD58yFRrnMH13HCsgJrnDk0K6+OaiL+fWCrT5lEA0dPZE6YPGCpL2dE8+4ZxvV249D
         1a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo5cTIL37FpYiHosBDpvR4kZAwB7mWQXF34HqE6NXHo=;
        b=DgDoG/JQBk4jD0GyIJQbST5/iVACq0CGIGRmUMIpITPi9ZH8utfUcRYRa3JYFnhppM
         b6NpB+7GZBU845m3rKI0Esx4eew6vK7qLIgLAWpiqdaZelV0DcczslRtAVNnhi7Jd+pX
         2mZ/lFuatfDyIWfPKVs0/drCkyTqK0LBYutLKl4OqUaNfABIW0F97tlZgD3BsDbCLIIk
         AKSbvsEBC/jNtDbt8HKawNituC67KwvPyKOeWNOa53DjZ6A5zT648Hefi68Ws8kSnOXP
         hsF23ARAyx/ZjV6OwRA+FcUZ4Ixx/za0XFiaNykVa0prgJ/498eNau1uss7DWD5rOxgo
         hhnA==
X-Gm-Message-State: AOAM533VxsDPSRhl4r6DRcvMNjHJGKFxxlAvlgxXz/vnn46vL5w98+mH
	bQW0kuATIgW2NtFOxbt4pvWAKWurr4xIQhEym6roOQ==
X-Google-Smtp-Source: ABdhPJwgEGyrPH+KoGgpyagYhDQWzp/X9Fcbf8BzrxMJ5Voz+JAHTmCCV7B6TldsquEEpVkTerwdy9arRqf3hvl6HiY=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr9688647edj.93.1592960627165;
 Tue, 23 Jun 2020 18:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
 <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com> <3015561.1592960116@warthog.procyon.org.uk>
In-Reply-To: <3015561.1592960116@warthog.procyon.org.uk>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Jun 2020 18:03:36 -0700
Message-ID: <CAPcyv4gdB6iOD8N0KAHY9WybpJtRx3EfEQCSM1zuTDkURrfuug@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To: David Howells <dhowells@redhat.com>
Message-ID-Hash: LQ4FAMFRP7F24PXYZD23LT24N3RK6CHJ
X-Message-ID-Hash: LQ4FAMFRP7F24PXYZD23LT24N3RK6CHJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "raven@themaw.net" <raven@themaw.net>, "kzak@redhat.com" <kzak@redhat.com>, "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dray@redhat.com" <dray@redhat.com>, "swhiteho@redhat.com" <swhiteho@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>, "jlayton@redhat.com" <jlayton@redhat.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "andres@anarazel.de" <andres@anarazel.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LQ4FAMFRP7F24PXYZD23LT24N3RK6CHJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2020 at 5:55 PM David Howells <dhowells@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > > This commit:
> > >
> > > >       keys: Make the KEY_NEED_* perms an enum rather than a mask
> > >
> > > ...upstream as:
> > >
> > >     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask
> > >
> > > ...triggers a regression in the libnvdimm unit test that exercises the
> > > encrypted keys used to store nvdimm passphrases. It results in the
> > > below warning.
> >
> > This regression is still present in tip of tree. David, have you had a
> > chance to take a look?
>
> nvdimm_lookup_user_key() needs to indicate to lookup_user_key() what it wants
> the key for so that the appropriate security checks can take place in SELinux
> and Smack.  Note that I have a patch in the works that changes this still
> further.
>
> Does setting the third argument of lookup_user_key() to KEY_NEED_SEARCH work
> for you?

It does, thanks.

Shall I wait for your further reworks to fix this for v5.8, or is that
v5.9 material?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
