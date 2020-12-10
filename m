Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 374DF2D5ED3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Dec 2020 16:01:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 432D7100EC1E8;
	Thu, 10 Dec 2020 07:01:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B848B100EE8C7
	for <linux-nvdimm@lists.01.org>; Thu, 10 Dec 2020 07:01:37 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAExYrr095140;
	Thu, 10 Dec 2020 15:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FYmEKQ2U2EKm52wTBJ8CEB8mol99E9bx4UF+alX7+h8=;
 b=Xz7Yc02LOfd5RZJ1eFNLI/u0iokDCqe2wM07ZPoWbpLS0XXofIMa60lY8Uc0t7qwqglh
 tnK/bc/4uftSUkC13pTc5KR5+TiUcrNum1HfaQrif69CrvsDWS/ydlyA62bSEhEugXLt
 JHp/nFkaRMOpLEpRoFxIw3syufz9Qx7a1dU5a/9Cq3jeYMkGzyCQYSOUnyIts0i12WDS
 ntNld2xLsUjeR53lvqk3mQ+r7XcCVpmKaOvwKeMg6ZFq939memurdinVfJCagbAkMUQp
 DC0UJOtpUzcp6LscZqXxr/zc5tGEECKIo8dsmoye86EraRkG3Wqvszb1/KyYc6S+2hvW bg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 35825mdu6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Dec 2020 15:01:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAF0dPX008717;
	Thu, 10 Dec 2020 15:01:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 358m41sm68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Dec 2020 15:01:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAF1Xld026338;
	Thu, 10 Dec 2020 15:01:34 GMT
Received: from [10.175.193.63] (/10.175.193.63)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 10 Dec 2020 07:01:33 -0800
Subject: Re: [PATCH ndctl v2 10/10] daxctl/test: Add tests for dynamic dax
 regions
From: Joao Martins <joao.m.martins@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
 <20200713160837.13774-11-joao.m.martins@oracle.com>
 <5cf76b3d-21db-daf9-dc1d-d38714a9a7c2@oracle.com>
Message-ID: <42e0711f-b26b-65af-4f12-efb28b07a096@oracle.com>
Date: Thu, 10 Dec 2020 15:01:30 +0000
MIME-Version: 1.0
In-Reply-To: <5cf76b3d-21db-daf9-dc1d-d38714a9a7c2@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100095
Message-ID-Hash: HCSREUGYM4PXB3FFSICSB6QUDKWUEIKA
X-Message-ID-Hash: HCSREUGYM4PXB3FFSICSB6QUDKWUEIKA
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HCSREUGYM4PXB3FFSICSB6QUDKWUEIKA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/21/20 5:49 PM, Joao Martins wrote:
> On 7/13/20 5:08 PM, Joao Martins wrote:
>> Add a couple tests which exercise the new sysfs based
>> interface for Soft-Reserved regions (by EFI/HMAT, or
>> efi_fake_mem).
>>
>> The tests exercise the daxctl orchestration surrounding
>> for creating/disabling/destroying/reconfiguring devices.
>> Furthermore it exercises dax region space allocation
>> code paths particularly:
>>
>>  1) zeroing out and reconfiguring a dax device from
>>  its current size to be max available and back to initial
>>  size
>>
>>  2) creates devices from holes in the beginning,
>>  middle of the region.
>>
>>  3) reconfigures devices in a interleaving fashion
>>
>>  4) test adjust of the region towards beginning and end
>>
>> The tests assume you pass a valid efi_fake_mem parameter
>> marked as EFI_MEMORY_SP e.g.
>>
>> 	efi_fake_mem=112G@16G:0x40000
>>
>> Naturally it bails out from the test if hmem device driver
>> isn't loaded or builtin. If hmem regions are found, only
>> region 0 is used, and the others remain untouched.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> 
> Following your suggestion[0], I added a couple more validations
> to this test suite, covering the mappings. So on top of this patch
> I added the following snip below the scissors mark. Mainly, I check
> that the size calculated by mappingNNNN is the same as advertised by
> the sysfs size attribute, thus looping through all the mappings.
> 
> Perhaps it would be enough to have just such validation in setup_dev()
> to catch the bug in [0]. But I went ahead and also validated the test
> cases where a certain amount of mappings are meant to be created.
> 
> My only worry is the last piece in daxctl_test_adjust() where we might
> be tying too much on how a kernel version picks space from the region;
> should this logic change in an unforeseeable future (e.g. allowing space
> at the beginning to be adjusted). Otherwise, if this no concern, let me
> know and I can resend a v3 with the adjustment below.
> 

Ping?

> ----->8------
> Subject: Validate @size versus mappingX sizes
> 
> [0]
> https://lore.kernel.org/linux-nvdimm/CAPcyv4hFS7JS9s7cUY=2Ru2kUTRsesxwX1PGnnc_tudJjoDUGw@mail.gmail.com/
> 
> ---
> 
>  test/daxctl-create.sh | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
> index 0d35112b4119..8dbc00fc574f 100755
> --- a/test/daxctl-create.sh
> +++ b/test/daxctl-create.sh
> @@ -46,8 +46,16 @@ find_testdev()
> 
>  setup_dev()
>  {
> +	local rc=1
> +	local nmaps=0
>  	test -n "$testdev"
> 
> +	nmaps=$(daxctl_get_nr_mappings "$testdev")
> +	if [[ $nmaps == 0 ]]; then
> +		printf "Device is idle"
> +		exit "$rc"
> +	fi
> +
>  	"$DAXCTL" disable-device "$testdev"
>  	"$DAXCTL" reconfigure-device -s 0 "$testdev"
>  	available=$("$DAXCTL" list -r 0 | jq -er '.[0].available_size | .//""')
> @@ -110,6 +118,47 @@ daxctl_get_mode()
>  	"$DAXCTL" list -d "$1" | jq -er '.[].mode'
>  }
> 
> +daxctl_get_size_by_mapping()
> +{
> +	local size=0
> +	local _start=0
> +	local _end=0
> +
> +	_start=$(cat $1/start)
> +	_end=$(cat $1/end)
> +	((size=size + _end - _start + 1))
> +	echo $size
> +}
> +
> +daxctl_get_nr_mappings()
> +{
> +	local i=0
> +	local _size=0
> +	local devsize=0
> +	local path=""
> +
> +	path=$(readlink -f /sys/bus/dax/devices/"$1"/)
> +	until ! [ -d $path/mapping$i ]
> +	do
> +		_size=$(daxctl_get_size_by_mapping "$path/mapping$i")
> +		if [[ $msize == 0 ]]; then
> +			i=0
> +			break
> +		fi
> +		((devsize=devsize + _size))
> +		((i=i + 1))
> +	done
> +
> +	# Return number of mappings if the sizes between size field
> +	# and the one computed by mappingNNN are the same
> +	_size=$("$DAXCTL" list -d $1 | jq -er '.[0].size | .//""')
> +	if [[ ! $_size == $devsize ]]; then
> +		echo 0
> +	else
> +		echo $i
> +	fi
> +}
> +
>  daxctl_test_multi()
>  {
>  	local daxdev
> @@ -139,6 +188,7 @@ daxctl_test_multi()
>  	new_size=$(expr $size \* 2)
>  	daxdev_4=$("$DAXCTL" create-device -r 0 -s $new_size | jq -er '.[].chardev')
>  	test -n $daxdev_4
> +	test $(daxctl_get_nr_mappings $daxdev_4) -eq 2
> 
>  	fail_if_available
> 
> @@ -173,6 +223,9 @@ daxctl_test_multi_reconfig()
>  		"$DAXCTL" reconfigure-device -s $i "$daxdev_1"
>  	done
> 
> +	test $(daxctl_get_nr_mappings $testdev) -eq $((ncfgs / 2))
> +	test $(daxctl_get_nr_mappings $daxdev_1) -eq $((ncfgs / 2))
> +
>  	fail_if_available
> 
>  	"$DAXCTL" disable-device "$daxdev_1" && "$DAXCTL" destroy-device "$daxdev_1"
> @@ -191,7 +244,8 @@ daxctl_test_adjust()
>  	start=$(expr $size + $size)
>  	for i in $(seq 1 1 $ncfgs)
>  	do
> -		daxdev=$("$DAXCTL" create-device -r 0 -s $size)
> +		daxdev=$("$DAXCTL" create-device -r 0 -s $size | jq -er '.[].chardev')
> +		test $(daxctl_get_nr_mappings $daxdev) -eq 1
>  	done
> 
>  	daxdev=$(daxctl_get_dev "dax0.1")
> @@ -202,10 +256,17 @@ daxctl_test_adjust()
>  	daxdev=$(daxctl_get_dev "dax0.2")
>  	"$DAXCTL" disable-device "$daxdev"
>  	"$DAXCTL" reconfigure-device -s $(expr $size \* 2) "$daxdev"
> +	# Allocates space at the beginning: expect two mappings as
> +	# as don't adjust the mappingX region. This is because we
> +	# preserve the relative page_offset of existing allocations
> +	test $(daxctl_get_nr_mappings $daxdev) -eq 2
> 
>  	daxdev=$(daxctl_get_dev "dax0.3")
>  	"$DAXCTL" disable-device "$daxdev"
>  	"$DAXCTL" reconfigure-device -s $(expr $size \* 2) "$daxdev"
> +	# Adjusts space at the end, expect one mapping because we are
> +	# able to extend existing region range.
> +	test $(daxctl_get_nr_mappings $daxdev) -eq 1
> 
>  	fail_if_available
> 
> @@ -232,6 +293,7 @@ daxctl_test1()
>  	daxdev=$("$DAXCTL" create-device -r 0 | jq -er '.[].chardev')
> 
>  	test -n "$daxdev"
> +	test $(daxctl_get_nr_mappings $daxdev) -eq 1
>  	fail_if_available
> 
>  	"$DAXCTL" disable-device "$daxdev" && "$DAXCTL" destroy-device "$daxdev"
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
